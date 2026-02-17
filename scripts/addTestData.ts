import { PrismaClient, MemoryType, GMemoryType, StorageType, SlotInterface } from '@prisma/client';
const prisma = new PrismaClient();

// Define a local enum for MotherboardSupport since it's not exported by Prisma.
const MotherboardSupportEnum = {
  ATX: "ATX",
  MicroATX: "MicroATX",
  MiniITX: "MiniITX",
  EATX: "EATX",
  SSI_EEB: "SSI_EEB"
} as const;

async function addTestData() {
  // -------------------------------
  // Create 2 CPUs
  // -------------------------------
  const cpuData = [
    {
      manufacturer: "Intel",
      series: "Core Ultra Series",
      modelName: "Core Ultra 265",
      architecture: "Arrow Lake",
      launchDate: new Date("2025-01-01"),
      numberOfCores: 20,
      numberOfThreads: 20,
      performanceCoreCount: 8,
      efficientCoreCount: 12,
      baseClock: 2.4,
      boostClock: 5.3,
      tdp: 65,
      maxTurboPower: 182,
      cacheL1: 1280,
      cacheL2: 36,
      cacheL3: 30,
      processNode: "TSMC N3B",
      memoryType: MemoryType.DDR5,
      maxMemoryChannels: 2,
      maxMemoryCapacity: 192,
      eccSupport: true,
      socketType: "LGA1851",
      unlocked: false,
      partNumber: "TEST-CPU-1",
      notes: "Test CPU 1",
      photo: ["https://example.com/cpu1.jpg"]
    },
    {
      manufacturer: "AMD",
      series: "Ryzen Series",
      modelName: "Ryzen 9 7950X",
      architecture: "Zen 4",
      launchDate: new Date("2023-09-01"),
      numberOfCores: 16,
      numberOfThreads: 32,
      performanceCoreCount: 16,
      efficientCoreCount: 0,
      baseClock: 3.5,
      boostClock: 4.7,
      tdp: 105,
      maxTurboPower: 142,
      cacheL1: 2048,
      cacheL2: 512,
      cacheL3: 64,
      processNode: "TSMC 5nm",
      memoryType: MemoryType.DDR5,
      maxMemoryChannels: 2,
      maxMemoryCapacity: 128,
      eccSupport: false,
      socketType: "AM5",
      unlocked: true,
      partNumber: "TEST-CPU-2",
      notes: "Test CPU 2",
      photo: ["https://example.com/cpu2.jpg"]
    }
  ];
  const cpus = await Promise.all(cpuData.map(data => prisma.cPU.create({ data })));

  // -------------------------------
  // Create 2 Motherboards
  // -------------------------------
  const moboData = [
    {
      manufacturer: "ASUS",
      modelName: "ROG Strix Z790-E",
      formFactor: "ATX",
      chipset: "Z790",
      cpuSocket: "LGA1851",
      memorySlots: 4,
      memoryType: MemoryType.DDR5,
      maxMemoryCapacity: 128,
      memorySpeedNotes: "DDR5-6400 OC",
      wifiSupport: true,
      wifiVersion: "Wi-Fi 6E",
      bluetoothSupport: true,
      bluetoothVersion: "5.3",
      releaseDate: new Date("2024-12-01"),
      partNumber: "TEST-MOBO-1",
      notes: "Test Motherboard 1",
      photo: ["https://example.com/mobo1.jpg"],
      // Dimensions in millimeters
      lengthmm: 300,
      widthmm: 250,
      heightmm: 50,
    },
    {
      manufacturer: "Gigabyte",
      modelName: "Z690 AORUS Pro",
      formFactor: "ATX",
      chipset: "Z690",
      cpuSocket: "LGA1700",
      memorySlots: 4,
      memoryType: MemoryType.DDR5,
      maxMemoryCapacity: 128,
      memorySpeedNotes: "DDR5-6400",
      wifiSupport: true,
      wifiVersion: "Wi-Fi 6E",
      partNumber: "TEST-MOBO-2",
      notes: "Test Motherboard 2",
      photo: ["https://example.com/mobo2.jpg"],
      lengthmm: 310,
      widthmm: 260,
      heightmm: 55,
    }
  ];
  const mobos = await Promise.all(moboData.map(data => prisma.motherboard.create({ data })));

  // -------------------------------
  // Create 2 GPUs
  // -------------------------------
  const gpuData = [
    {
      brand: "NVIDIA",
      manufacturer: "MSI",
      modelName: "RTX 4080 Ventus",
      series: "GeForce RTX 4000 Series",
      gpuEngine: "Ada Lovelace",
      cudaCores: 9728,
      baseClockMHz: 2200,
      boostClockMHz: 2500,
      memorySizeGB: 16,
      memoryType: GMemoryType.GDDR6X,
      memorySpeedGbps: 22,
      memoryBusWidth: 256,
      busInterface: SlotInterface.PCIE_4_0,
      typicalBoardPower: 320,
      recommendedPSU: 750,
      maxResolution: "7680x4320",
      partNumber: "TEST-GPU-1",
      notes: "Test GPU 1",
      photo: ["https://example.com/gpu1.jpg"],
      lengthMm: 400,
      widthMm: 150,
      heightMm: 50,
    },
    {
      brand: "AMD",
      manufacturer: "Sapphire",
      modelName: "Radeon RX 7900 XTX",
      series: "Radeon RX 7000 Series",
      gpuEngine: "RDNA 3",
      cudaCores: null,
      baseClockMHz: 1800,
      boostClockMHz: 2400,
      memorySizeGB: 20,
      memoryType: GMemoryType.GDDR6,
      memorySpeedGbps: 20,
      memoryBusWidth: 320,
      busInterface: SlotInterface.PCIE_4_0,
      typicalBoardPower: 300,
      recommendedPSU: 850,
      maxResolution: "7680x4320",
      partNumber: "TEST-GPU-2",
      notes: "Test GPU 2",
      photo: ["https://example.com/gpu2.jpg"],
      lengthMm: 450,
      widthMm: 160,
      heightMm: 60,
    }
  ];
  const gpus = await Promise.all(gpuData.map(data => prisma.gPU.create({ data })));

  // -------------------------------
  // Create 2 RAM modules
  // -------------------------------
  const ramData = [
    {
      brand: "Corsair",
      manufacturer: "Corsair",
      series: "Vengeance LPX",
      modelName: "CMK16GX4M2B3200C16",
      memoryType: MemoryType.DDR4,
      formFactor: "UDIMM",
      capacityGb: 16,
      kitSize: 2,
      speedMt: 3200,
      voltage: 1.35,
      latency: "16-18-18-36",
      partNumber: "TEST-RAM-1",
      notes: "Test RAM 1",
      photo: ["https://example.com/ram1.jpg"]
    },
    {
      brand: "G.Skill",
      manufacturer: "G.Skill",
      series: "Trident Z Neo",
      modelName: "F4-3600C16D-16GTZN",
      memoryType: MemoryType.DDR4,
      formFactor: "UDIMM",
      capacityGb: 16,
      kitSize: 2,
      speedMt: 3600,
      voltage: 1.35,
      latency: "16-18-18-38",
      partNumber: "TEST-RAM-2",
      notes: "Test RAM 2",
      photo: ["https://example.com/ram2.jpg"]
    }
  ];
  const rams = await Promise.all(ramData.map(data => prisma.rAM.create({ data })));

  // -------------------------------
  // Create 2 Storage drives
  // -------------------------------
  const storageData = [
    {
      manufacturer: "Samsung",
      modelName: "970 EVO Plus",
      storageType: StorageType.NVME,
      capacityGb: 1000,
      interface: "NVMe",
      partNumber: "TEST-STORAGE-1",
      notes: "Test Storage 1",
      photo: ["https://example.com/storage1.jpg"]
    },
    {
      manufacturer: "Western Digital",
      modelName: "Blue SN570",
      storageType: StorageType.NVME,
      capacityGb: 1000,
      interface: "NVMe",
      partNumber: "TEST-STORAGE-2",
      notes: "Test Storage 2",
      photo: ["https://example.com/storage2.jpg"]
    }
  ];
  const storages = await Promise.all(storageData.map(data => prisma.storage.create({ data })));

  // -------------------------------
  // Create 2 Computer Cases
  // -------------------------------
  const caseData = [
    {
      manufacturer: "Corsair",
      modelName: "O11 Dynamic",
      caseType: "Tower Chassis",
      color: "Black",
      heightmm: 450,
      widthmm: 280,
      lengthmm: 440,
      material: "Steel, tempered glass, Aluminium",
      motherboardSupport: MotherboardSupportEnum.ATX,
      expansionSlots: "6+1",
      storage: "2 x 2.5″ behind MB tray; 2 x 3.5″ HDD cage",
      gpuClearance: 408,
      cpuCoolerClearance: 164,
      psuSupport: "ATX (Under 220mm)",
      ioPorts: JSON.stringify({ ports: ["Power Button", "2x USB 3.0", "1x USB 3.1 Type-C", "Audio"] }),
      dustFilter: "1 x Bottom",
      weight: 13.1,
      partNumber: "TEST-CASE-1",
      notes: "Test Computer Case 1",
      photo: ["https://example.com/case1.jpg"]
      // Fan and radiator support can be added via separate models.
    },
    {
      manufacturer: "NZXT",
      modelName: "H510",
      caseType: "Mid Tower",
      color: "White",
      heightmm: 500,
      widthmm: 300,
      lengthmm: 460,
      material: "Steel, tempered glass",
      motherboardSupport: MotherboardSupportEnum.ATX,
      expansionSlots: "7",
      storage: "Front: 2 x 2.5″, Rear: 2 x 3.5″",
      gpuClearance: 420,
      cpuCoolerClearance: 170,
      psuSupport: "ATX (Under 220mm)",
      ioPorts: JSON.stringify({ ports: ["Power Button", "2x USB 3.0", "1x USB-C", "Audio"] }),
      dustFilter: "Front & Bottom",
      weight: 14.0,
      partNumber: "TEST-CASE-2",
      notes: "Test Computer Case 2",
      photo: ["https://example.com/case2.jpg"]
    }
  ];
  const cases = await Promise.all(caseData.map(data => prisma.computerCase.create({ data })));

  // -------------------------------
  // Create 2 PSUs
  // -------------------------------
  const psuData = [
    {
      manufacturer: "Corsair",
      modelName: "RM750x",
      wattage: 750,
      efficiencyRating: "80+ Gold",
      modular: true,
      partNumber: "TEST-PSU-1",
      notes: "Test PSU 1",
      photo: ["https://example.com/psu1.jpg"]
    },
    {
      manufacturer: "EVGA",
      modelName: "SuperNOVA 850 G5",
      wattage: 850,
      efficiencyRating: "80+ Gold",
      modular: true,
      partNumber: "TEST-PSU-2",
      notes: "Test PSU 2",
      photo: ["https://example.com/psu2.jpg"]
    }
  ];
  const psus = await Promise.all(psuData.map(data => prisma.pSU.create({ data })));

  // -------------------------------
  // Create 2 CPUCoolers
  // -------------------------------
  const cpuCoolerData = [
    {
      manufacturer: "NZXT",
      modelName: "Kraken Elite 240",
      type: "Liquid",
      lcdDiameter: 69,
      lcdColors: "16.7 million",
      lcdResolution: "640x640",
      lcdBrightness: 690,
      lcdPanelType: "IPS",
      lcdRefreshRate: 60,
      lcdOrientation: "Software adjustable",
      pumpName: "NZXT Turbine Pump",
      pumpMotorSpeedMin: 1200,
      pumpMotorSpeedMax: 2800,
      pumpMotorVariance: 300,
      pumpPower: 3,
      capDiameter: 93.5,
      capHeight: 65,
      capMaterial: "Plastic",
      capRingMaterial: "Plastic",
      capColdPlateMaterial: "Copper",
      capHousingMaterial: "Plastic",
      tubingLengthmm: 400,
      tubingMaterial: "CIIR rubber with PET braided sleeve",
      socketSupport: ["Intel LGA1851", "Intel LGA1700", "AMD AM5", "AMD AM4"],
      lengthmm: 240,
      widthmm: 120,
      heightmm: 30,
      partNumber: "TEST-CPUCOOLER-1",
      notes: "Test CPU Cooler 1",
      photo: ["https://example.com/cooler1.jpg"]
    },
    {
      manufacturer: "Noctua",
      modelName: "NH-D15",
      type: "Air",
      lcdDiameter: null,
      lcdColors: null,
      lcdResolution: null,
      lcdBrightness: null,
      lcdPanelType: null,
      lcdRefreshRate: null,
      lcdOrientation: null,
      pumpName: null,
      pumpMotorSpeedMin: null,
      pumpMotorSpeedMax: null,
      pumpMotorVariance: null,
      pumpPower: null,
      capDiameter: null,
      capHeight: null,
      capMaterial: null,
      capRingMaterial: null,
      capColdPlateMaterial: null,
      capHousingMaterial: null,
      tubingLengthmm: null,
      tubingMaterial: null,
      socketSupport: ["Intel LGA1700", "Intel LGA1200", "AMD AM4", "AMD AM5"],
      lengthmm: 150,
      widthmm: 120,
      heightmm: 180,
      partNumber: "TEST-CPUCOOLER-2",
      notes: "Test CPU Cooler 2",
      photo: ["https://example.com/cooler2.jpg"]
    }
  ];
  const cpuCoolers = await Promise.all(cpuCoolerData.map(data => prisma.cPUCooler.create({ data })));

  // -------------------------------
  // Create 2 PreBuild records
  // -------------------------------
  const preBuildData = [
    {
      name: "Test PreBuild 1",
      cpuId: cpus[0].id,
      moboId: mobos[0].id,
      gpuId: gpus[0].id,
      ramId: rams[0].id,
      storageId: storages[0].id,
      computerCaseId: cases[0].id,
      psuId: psus[0].id,
    },
    {
      name: "Test PreBuild 2",
      cpuId: cpus[1].id,
      moboId: mobos[1].id,
      gpuId: gpus[1].id,
      ramId: rams[1].id,
      storageId: storages[1].id,
      computerCaseId: cases[1].id,
      psuId: psus[1].id,
    }
  ];
  const preBuilds = await Promise.all(preBuildData.map(data => prisma.preBuild.create({ data })));

  console.log("Test Data Created:");
  console.log({ cpus, mobos, gpus, rams, storages, cases, psus, cpuCoolers, preBuilds });
}

addTestData()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (error) => {
    console.error(error);
    await prisma.$disconnect();
    process.exit(1);
  });
