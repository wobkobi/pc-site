-- CreateEnum
CREATE TYPE "SlotInterface" AS ENUM ('PCIE_5_0', 'PCIE_4_0', 'PCIE_3_0', 'PCIE_2_0', 'OTHER');

-- CreateEnum
CREATE TYPE "MemoryType" AS ENUM ('DDR3', 'DDR4', 'DDR5', 'OTHER');

-- CreateEnum
CREATE TYPE "GMemoryType" AS ENUM ('GDDR3', 'GDDR4', 'GDDR5', 'GDDR5X', 'GDDR6', 'GDDR6X', 'GDDR7', 'HBM2', 'HBM2E', 'OTHER');

-- CreateEnum
CREATE TYPE "StorageType" AS ENUM ('M2', 'SATA', 'NVME', 'OTHER');

-- CreateTable
CREATE TABLE "CPU" (
    "id" SERIAL NOT NULL,
    "manufacturer" TEXT NOT NULL DEFAULT 'Unknown',
    "series" TEXT NOT NULL DEFAULT 'Unknown',
    "modelName" TEXT NOT NULL DEFAULT 'Unknown',
    "architecture" TEXT NOT NULL DEFAULT 'Unknown',
    "launchDate" TIMESTAMP(3),
    "numberOfCores" INTEGER NOT NULL DEFAULT 0,
    "numberOfThreads" INTEGER NOT NULL DEFAULT 0,
    "performanceCoreCount" INTEGER,
    "efficientCoreCount" INTEGER,
    "baseClock" DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    "boostClock" DOUBLE PRECISION,
    "pCoreBaseFreq" DOUBLE PRECISION,
    "pCoreMaxFreq" DOUBLE PRECISION,
    "eCoreBaseFreq" DOUBLE PRECISION,
    "eCoreMaxFreq" DOUBLE PRECISION,
    "tdp" DOUBLE PRECISION,
    "maxTurboPower" DOUBLE PRECISION,
    "cacheL1" INTEGER,
    "cacheL2" INTEGER,
    "cacheL3" INTEGER,
    "processNode" TEXT,
    "memoryType" "MemoryType",
    "maxMemoryChannels" INTEGER,
    "maxMemoryCapacity" DOUBLE PRECISION,
    "eccSupport" BOOLEAN NOT NULL DEFAULT false,
    "integratedGpuId" INTEGER,
    "npuName" TEXT,
    "npuPeakTops" INTEGER,
    "npuSparsitySupport" BOOLEAN,
    "overallPeakTops" INTEGER,
    "aiAccelFeatures" TEXT,
    "instructionSet" TEXT,
    "instructionExtensions" TEXT,
    "virtualizationSupport" TEXT,
    "securityFeatures" TEXT,
    "socketType" TEXT NOT NULL DEFAULT 'Unknown',
    "slotInterface" "SlotInterface",
    "pciExpressLanes" INTEGER,
    "unlocked" BOOLEAN NOT NULL DEFAULT false,
    "partNumber" TEXT NOT NULL,
    "notes" TEXT,
    "photo" TEXT,

    CONSTRAINT "CPU_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Motherboard" (
    "id" SERIAL NOT NULL,
    "manufacturer" TEXT NOT NULL DEFAULT 'Unknown',
    "modelName" TEXT NOT NULL DEFAULT 'Unknown',
    "formFactor" TEXT,
    "chipset" TEXT NOT NULL,
    "cpuSocket" TEXT NOT NULL,
    "memorySlots" INTEGER,
    "memoryType" "MemoryType",
    "maxMemoryCapacity" INTEGER,
    "memorySpeedNotes" TEXT,
    "wifiSupport" BOOLEAN NOT NULL DEFAULT false,
    "wifiVersion" TEXT,
    "bluetoothSupport" BOOLEAN NOT NULL DEFAULT false,
    "bluetoothVersion" TEXT,
    "releaseDate" TIMESTAMP(3),
    "partNumber" TEXT NOT NULL,
    "notes" TEXT,
    "photo" TEXT,

    CONSTRAINT "Motherboard_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EthernetPort" (
    "id" SERIAL NOT NULL,
    "portCount" INTEGER NOT NULL,
    "speedGbps" DOUBLE PRECISION,
    "notes" TEXT,
    "motherboardId" INTEGER NOT NULL,

    CONSTRAINT "EthernetPort_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MotherboardUSBPort" (
    "id" SERIAL NOT NULL,
    "usbStandard" TEXT NOT NULL,
    "portCount" INTEGER NOT NULL,
    "notes" TEXT,
    "motherboardId" INTEGER NOT NULL,

    CONSTRAINT "MotherboardUSBPort_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MotherboardVideoOutput" (
    "id" SERIAL NOT NULL,
    "outputType" TEXT NOT NULL,
    "version" TEXT,
    "portCount" INTEGER NOT NULL,
    "notes" TEXT,
    "motherboardId" INTEGER NOT NULL,

    CONSTRAINT "MotherboardVideoOutput_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MotherboardAudioJack" (
    "id" SERIAL NOT NULL,
    "jackType" TEXT NOT NULL,
    "usage" TEXT,
    "portCount" INTEGER NOT NULL,
    "notes" TEXT,
    "motherboardId" INTEGER NOT NULL,

    CONSTRAINT "MotherboardAudioJack_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MotherboardInternalHeader" (
    "id" SERIAL NOT NULL,
    "headerType" TEXT NOT NULL,
    "headerCount" INTEGER NOT NULL,
    "notes" TEXT,
    "motherboardId" INTEGER NOT NULL,

    CONSTRAINT "MotherboardInternalHeader_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ExpansionSlot" (
    "id" SERIAL NOT NULL,
    "slotName" TEXT,
    "slotInterface" "SlotInterface" NOT NULL,
    "maxLanes" INTEGER,
    "notes" TEXT,
    "motherboardId" INTEGER NOT NULL,

    CONSTRAINT "ExpansionSlot_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StorageSlot" (
    "id" SERIAL NOT NULL,
    "storageType" "StorageType" NOT NULL,
    "keyFormFactor" TEXT,
    "interface" "SlotInterface",
    "pcieVersion" "SlotInterface",
    "sataSupport" BOOLEAN,
    "notes" TEXT,
    "motherboardId" INTEGER NOT NULL,

    CONSTRAINT "StorageSlot_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GPU" (
    "id" SERIAL NOT NULL,
    "brand" TEXT NOT NULL,
    "manufacturer" TEXT,
    "modelName" TEXT NOT NULL,
    "series" TEXT,
    "gpuEngine" TEXT,
    "cudaCores" INTEGER,
    "streamProcessors" INTEGER,
    "computeUnits" INTEGER,
    "rayAccelerators" INTEGER,
    "baseClockMHz" INTEGER,
    "boostClockMHz" INTEGER,
    "memorySizeGB" INTEGER NOT NULL,
    "memoryType" "GMemoryType" NOT NULL,
    "memorySpeedGbps" DOUBLE PRECISION,
    "memoryBusWidth" INTEGER,
    "busInterface" "SlotInterface",
    "typicalBoardPower" INTEGER,
    "recommendedPSU" INTEGER,
    "powerConnectors" TEXT,
    "lengthMm" DOUBLE PRECISION,
    "widthMm" DOUBLE PRECISION,
    "heightMm" DOUBLE PRECISION,
    "slotSize" DOUBLE PRECISION,
    "maxResolution" TEXT,
    "maxMonitors" INTEGER,
    "directXVersion" TEXT,
    "openGLVersion" TEXT,
    "multiGpuSupport" TEXT,
    "releaseDate" TIMESTAMP(3),
    "partNumber" TEXT NOT NULL,
    "notes" TEXT,
    "photo" TEXT,

    CONSTRAINT "GPU_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GPUVideoOutput" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "version" TEXT,
    "portCount" INTEGER NOT NULL,
    "notes" TEXT,
    "gpuId" INTEGER NOT NULL,

    CONSTRAINT "GPUVideoOutput_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RAM" (
    "id" SERIAL NOT NULL,
    "brand" TEXT,
    "manufacturer" TEXT NOT NULL,
    "series" TEXT,
    "modelName" TEXT NOT NULL,
    "memoryType" "MemoryType" NOT NULL,
    "formFactor" TEXT NOT NULL,
    "capacityGb" DOUBLE PRECISION NOT NULL,
    "kitSize" INTEGER NOT NULL DEFAULT 1,
    "speedMt" INTEGER,
    "voltage" DOUBLE PRECISION,
    "latency" TEXT,
    "eccSupport" BOOLEAN NOT NULL DEFAULT false,
    "registeredUnbuffered" TEXT,
    "ledLighting" TEXT,
    "heightMm" DOUBLE PRECISION,
    "releaseDate" TIMESTAMP(3),
    "partNumber" TEXT NOT NULL,
    "notes" TEXT,
    "photo" TEXT,

    CONSTRAINT "RAM_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Storage" (
    "id" SERIAL NOT NULL,
    "manufacturer" TEXT NOT NULL,
    "modelName" TEXT NOT NULL,
    "storageType" "StorageType" NOT NULL,
    "capacityGb" DOUBLE PRECISION NOT NULL,
    "interface" TEXT,
    "partNumber" TEXT NOT NULL,
    "notes" TEXT,
    "photo" TEXT,

    CONSTRAINT "Storage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ComputerCase" (
    "id" SERIAL NOT NULL,
    "manufacturer" TEXT NOT NULL,
    "modelName" TEXT NOT NULL,
    "caseType" TEXT,
    "color" TEXT,
    "dimensions" TEXT,
    "material" TEXT,
    "motherboardSupport" TEXT,
    "expansionSlots" TEXT,
    "storage" TEXT,
    "gpuClearance" TEXT,
    "cpuCoolerClearance" TEXT,
    "psuSupport" TEXT,
    "fanSupport" TEXT,
    "radiatorSupport" TEXT,
    "ioPorts" TEXT,
    "dustFilter" TEXT,
    "weight" DOUBLE PRECISION,
    "partNumber" TEXT NOT NULL,
    "photo" TEXT,

    CONSTRAINT "ComputerCase_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PSU" (
    "id" SERIAL NOT NULL,
    "manufacturer" TEXT NOT NULL,
    "modelName" TEXT NOT NULL,
    "wattage" INTEGER NOT NULL,
    "efficiencyRating" TEXT,
    "modular" BOOLEAN NOT NULL DEFAULT false,
    "partNumber" TEXT NOT NULL,
    "notes" TEXT,
    "photo" TEXT,

    CONSTRAINT "PSU_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Fan" (
    "id" SERIAL NOT NULL,
    "manufacturer" TEXT,
    "modelName" TEXT NOT NULL,
    "fanConnector" TEXT,
    "speed" TEXT,
    "airflow" TEXT,
    "staticPressure" TEXT,
    "noise" TEXT,
    "partNumber" TEXT NOT NULL,
    "notes" TEXT,
    "photo" TEXT,

    CONSTRAINT "Fan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PreBuild" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "cpuId" INTEGER NOT NULL,
    "moboId" INTEGER NOT NULL,
    "gpuId" INTEGER,
    "ramId" INTEGER NOT NULL,
    "storageId" INTEGER NOT NULL,
    "computerCaseId" INTEGER NOT NULL,
    "psuId" INTEGER NOT NULL,

    CONSTRAINT "PreBuild_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "CPU_integratedGpuId_key" ON "CPU"("integratedGpuId");

-- AddForeignKey
ALTER TABLE "CPU" ADD CONSTRAINT "CPU_integratedGpuId_fkey" FOREIGN KEY ("integratedGpuId") REFERENCES "GPU"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EthernetPort" ADD CONSTRAINT "EthernetPort_motherboardId_fkey" FOREIGN KEY ("motherboardId") REFERENCES "Motherboard"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MotherboardUSBPort" ADD CONSTRAINT "MotherboardUSBPort_motherboardId_fkey" FOREIGN KEY ("motherboardId") REFERENCES "Motherboard"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MotherboardVideoOutput" ADD CONSTRAINT "MotherboardVideoOutput_motherboardId_fkey" FOREIGN KEY ("motherboardId") REFERENCES "Motherboard"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MotherboardAudioJack" ADD CONSTRAINT "MotherboardAudioJack_motherboardId_fkey" FOREIGN KEY ("motherboardId") REFERENCES "Motherboard"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MotherboardInternalHeader" ADD CONSTRAINT "MotherboardInternalHeader_motherboardId_fkey" FOREIGN KEY ("motherboardId") REFERENCES "Motherboard"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExpansionSlot" ADD CONSTRAINT "ExpansionSlot_motherboardId_fkey" FOREIGN KEY ("motherboardId") REFERENCES "Motherboard"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StorageSlot" ADD CONSTRAINT "StorageSlot_motherboardId_fkey" FOREIGN KEY ("motherboardId") REFERENCES "Motherboard"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GPUVideoOutput" ADD CONSTRAINT "GPUVideoOutput_gpuId_fkey" FOREIGN KEY ("gpuId") REFERENCES "GPU"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PreBuild" ADD CONSTRAINT "PreBuild_cpuId_fkey" FOREIGN KEY ("cpuId") REFERENCES "CPU"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PreBuild" ADD CONSTRAINT "PreBuild_moboId_fkey" FOREIGN KEY ("moboId") REFERENCES "Motherboard"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PreBuild" ADD CONSTRAINT "PreBuild_gpuId_fkey" FOREIGN KEY ("gpuId") REFERENCES "GPU"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PreBuild" ADD CONSTRAINT "PreBuild_ramId_fkey" FOREIGN KEY ("ramId") REFERENCES "RAM"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PreBuild" ADD CONSTRAINT "PreBuild_storageId_fkey" FOREIGN KEY ("storageId") REFERENCES "Storage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PreBuild" ADD CONSTRAINT "PreBuild_computerCaseId_fkey" FOREIGN KEY ("computerCaseId") REFERENCES "ComputerCase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PreBuild" ADD CONSTRAINT "PreBuild_psuId_fkey" FOREIGN KEY ("psuId") REFERENCES "PSU"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
