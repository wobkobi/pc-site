'use client';

import React, { useState, useEffect } from "react";
import { CPU, Motherboard, GPU, RAM, Storage, ComputerCase, PSU } from "@/lib/types";

type PartCategory = "cpu" | "motherboard" | "gpu" | "ram" | "storage" | "computerCase" | "psu" | null;

export default function BuildPage() {
  // Data arrays.
  const [cpus, setCpus] = useState<CPU[]>([]);
  const [motherboards, setMotherboards] = useState<Motherboard[]>([]);
  const [gpus, setGpus] = useState<GPU[]>([]);
  const [rams, setRams] = useState<RAM[]>([]);
  const [storages, setStorages] = useState<Storage[]>([]);
  const [cases, setCases] = useState<ComputerCase[]>([]);
  const [psus, setPsus] = useState<PSU[]>([]);

  // Selected parts.
  const [selectedCPU, setSelectedCPU] = useState<CPU | null>(null);
  const [selectedMobo, setSelectedMobo] = useState<Motherboard | null>(null);
  const [selectedGPU, setSelectedGPU] = useState<GPU | null>(null);
  const [selectedRAM, setSelectedRAM] = useState<RAM | null>(null);
  const [selectedStorage, setSelectedStorage] = useState<Storage | null>(null);
  const [selectedCase, setSelectedCase] = useState<ComputerCase | null>(null);
  const [selectedPSU, setSelectedPSU] = useState<PSU | null>(null);

  // Which category is currently open (modal visible).
  const [activeCategory, setActiveCategory] = useState<PartCategory>(null);

  // Fetch available parts.
  useEffect(() => {
    fetch("/api/parts?type=cpu")
      .then((res) => res.json())
      .then((data) => Array.isArray(data) ? setCpus(data) : setCpus([]))
      .catch((err) => console.error("Error fetching CPUs:", err));

    fetch("/api/parts?type=motherboard")
      .then((res) => res.json())
      .then((data) => Array.isArray(data) ? setMotherboards(data) : setMotherboards([]))
      .catch((err) => console.error("Error fetching Motherboards:", err));

    fetch("/api/parts?type=gpu")
      .then((res) => res.json())
      .then((data) => Array.isArray(data) ? setGpus(data) : setGpus([]))
      .catch((err) => console.error("Error fetching GPUs:", err));

    fetch("/api/parts?type=ram")
      .then((res) => res.json())
      .then((data) => Array.isArray(data) ? setRams(data) : setRams([]))
      .catch((err) => console.error("Error fetching RAM:", err));

    fetch("/api/parts?type=storage")
      .then((res) => res.json())
      .then((data) => Array.isArray(data) ? setStorages(data) : setStorages([]))
      .catch((err) => console.error("Error fetching Storage:", err));

    fetch("/api/parts?type=computerCase")
      .then((res) => res.json())
      .then((data) => Array.isArray(data) ? setCases(data) : setCases([]))
      .catch((err) => console.error("Error fetching Computer Cases:", err));

    fetch("/api/parts?type=psu")
      .then((res) => res.json())
      .then((data) => Array.isArray(data) ? setPsus(data) : setPsus([]))
      .catch((err) => console.error("Error fetching PSUs:", err));
  }, []);

  // Compatibility Filtering
  const getFilteredParts = (category: PartCategory) => {
    switch (category) {
      case "cpu":
        // If a motherboard is selected, only show CPUs with a matching socket.
        return selectedMobo && selectedMobo.cpuSocket
          ? cpus.filter(cpu => cpu.socketType === selectedMobo.cpuSocket)
          : cpus;
      case "motherboard":
        let filtered = motherboards;
        if (selectedCPU) {
          filtered = filtered.filter(mobo => mobo.cpuSocket === selectedCPU.socketType);
        }
        // Filter by computer case support.
        if (selectedCase && selectedCase.motherboardSupport && selectedMobo?.formFactor) {
          const caseSupport = selectedCase.motherboardSupport.toLowerCase();
          filtered = filtered.filter(mobo =>
            (mobo.formFactor?.toLowerCase() || "").length > 0 &&
            caseSupport.includes(mobo.formFactor?.toLowerCase() || "")
          );
        }
        return filtered;
      case "gpu":
        if (selectedCase && selectedCase.gpuClearance != null) {
          // Ensure gpuClearance is a number.
          const clearance = typeof selectedCase.gpuClearance === "number"
            ? selectedCase.gpuClearance
            : parseFloat(String(selectedCase.gpuClearance));
          if (isNaN(clearance)) return [];
          return gpus.filter(gpu => gpu.lengthMm != null && gpu.lengthMm <= clearance);
        }
        return gpus;
      case "ram":
        return rams;
      case "storage":
        return storages;
      case "computerCase":
        if (selectedMobo && selectedMobo.formFactor && selectedCase?.motherboardSupport) {
          return cases.filter(cs =>
            cs.motherboardSupport?.toLowerCase().includes(selectedMobo.formFactor?.toLowerCase() || "")
          );
        }
        return cases;
      case "psu":
        return psus;
      default:
        return [];
    }
  };

  const handleSelect = (category: Exclude<PartCategory, null>, part: any) => {
    switch (category) {
      case "cpu":
        setSelectedCPU(part);
        break;
      case "motherboard":
        setSelectedMobo(part);
        break;
      case "gpu":
        setSelectedGPU(part);
        break;
      case "ram":
        setSelectedRAM(part);
        break;
      case "storage":
        setSelectedStorage(part);
        break;
      case "computerCase":
        setSelectedCase(part);
        break;
      case "psu":
        setSelectedPSU(part);
        break;
    }
    setActiveCategory(null);
  };

  // Render a category box.
  const renderCategoryBox = (category: Exclude<PartCategory, null>, label: string, selectedPart: any) => (
    <div
      onClick={() => setActiveCategory(category)}
      style={{
        border: "1px solid #ccc",
        borderRadius: "8px",
        padding: "16px",
        margin: "8px",
        cursor: "pointer",
        minWidth: "150px",
        textAlign: "center"
      }}
    >
      {selectedPart ? (
        <>
          <img
            src={Array.isArray(selectedPart.photo) ? selectedPart.photo[0] : selectedPart.photo}
            alt={selectedPart.modelName}
            style={{ width: "100%", height: "100px", objectFit: "cover", borderRadius: "4px" }}
          />
          <p style={{ fontWeight: "bold", margin: "8px 0 4px" }}>{selectedPart.modelName}</p>
          <p style={{ fontSize: "0.8em", color: "#555" }}>{selectedPart.partNumber}</p>
        </>
      ) : (
        <p>Select {label}</p>
      )}
    </div>
  );

  // Render the modal dropdown list.
  const renderDropdown = () => {
    if (!activeCategory) return null;
    const parts = getFilteredParts(activeCategory);
    return (
      <div
        style={{
          position: "fixed",
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          background: "rgba(0,0,0,0.5)",
          display: "flex",
          justifyContent: "center",
          alignItems: "center",
          zIndex: 1000
        }}
        onClick={() => setActiveCategory(null)}
      >
        <div
          style={{
            background: "#fff",
            borderRadius: "8px",
            padding: "16px",
            maxHeight: "80vh",
            overflowY: "auto"
          }}
          onClick={(e) => e.stopPropagation()}
        >
          <h3>Select {activeCategory}</h3>
          <div style={{ display: "flex", flexWrap: "wrap" }}>
            {parts.map((part: any) => (
              <div
                key={part.id}
                onClick={() => handleSelect(activeCategory, part)}
                style={{
                  border: "1px solid #ccc",
                  borderRadius: "8px",
                  padding: "8px",
                  margin: "8px",
                  cursor: "pointer",
                  width: "150px",
                  textAlign: "center"
                }}
              >
                <img
                  src={Array.isArray(part.photo) ? part.photo[0] : part.photo}
                  alt={part.modelName}
                  style={{
                    width: "100%",
                    height: "100px",
                    objectFit: "cover",
                    borderRadius: "4px"
                  }}
                />
                <p style={{ margin: "4px 0", fontWeight: "bold" }}>{part.modelName}</p>
                <p style={{ fontSize: "0.8em", color: "#555" }}>{part.partNumber}</p>
              </div>
            ))}
          </div>
        </div>
      </div>
    );
  };

  return (
    <div style={{ padding: "2rem" }}>
      <h1>Build Your Own PC</h1>
      <div style={{ display: "flex", flexWrap: "wrap" }}>
        {renderCategoryBox("cpu", "CPU", selectedCPU)}
        {renderCategoryBox("motherboard", "Motherboard", selectedMobo)}
        {renderCategoryBox("gpu", "GPU", selectedGPU)}
        {renderCategoryBox("ram", "RAM", selectedRAM)}
        {renderCategoryBox("storage", "Storage", selectedStorage)}
        {renderCategoryBox("computerCase", "Computer Case", selectedCase)}
        {renderCategoryBox("psu", "PSU", selectedPSU)}
      </div>
      {renderDropdown()}
      <section style={{ marginTop: "2rem", padding: "1rem", border: "1px solid #ccc", borderRadius: "8px" }}>
        <h2>Build Summary</h2>
        <ul>
          <li>CPU: {selectedCPU ? selectedCPU.modelName : "Not selected"}</li>
          <li>Motherboard: {selectedMobo ? selectedMobo.modelName : "Not selected"}</li>
          <li>GPU: {selectedGPU ? selectedGPU.modelName : "Not selected"}</li>
          <li>RAM: {selectedRAM ? selectedRAM.modelName : "Not selected"}</li>
          <li>Storage: {selectedStorage ? selectedStorage.modelName : "Not selected"}</li>
          <li>Case: {selectedCase ? selectedCase.modelName : "Not selected"}</li>
          <li>PSU: {selectedPSU ? selectedPSU.modelName : "Not selected"}</li>
        </ul>
        <button
          style={{ padding: "0.5rem 1rem", fontSize: "1rem", cursor: "pointer" }}
          onClick={() => {
            console.log({
              CPU: selectedCPU,
              Motherboard: selectedMobo,
              GPU: selectedGPU,
              RAM: selectedRAM,
              Storage: selectedStorage,
              ComputerCase: selectedCase,
              PSU: selectedPSU
            });
            alert("Build finalized! Check console for details.");
          }}
        >
          Finalize Build
        </button>
      </section>
    </div>
  );
}
