/*
  Warnings:

  - You are about to drop the column `brand` on the `CPU` table. All the data in the column will be lost.
  - You are about to drop the column `generation` on the `CPU` table. All the data in the column will be lost.
  - You are about to drop the column `model` on the `CPU` table. All the data in the column will be lost.
  - You are about to drop the column `socket` on the `CPU` table. All the data in the column will be lost.
  - You are about to drop the column `chipset` on the `GPU` table. All the data in the column will be lost.
  - You are about to drop the column `memory` on the `GPU` table. All the data in the column will be lost.
  - You are about to drop the column `model` on the `GPU` table. All the data in the column will be lost.
  - You are about to drop the column `brand` on the `Motherboard` table. All the data in the column will be lost.
  - You are about to drop the column `model` on the `Motherboard` table. All the data in the column will be lost.
  - You are about to drop the column `socket` on the `Motherboard` table. All the data in the column will be lost.
  - You are about to drop the column `model` on the `RAM` table. All the data in the column will be lost.
  - You are about to drop the column `speed` on the `RAM` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `RAM` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[integratedGpuId]` on the table `CPU` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `memorySizeGB` to the `GPU` table without a default value. This is not possible if the table is not empty.
  - Added the required column `memoryType` to the `GPU` table without a default value. This is not possible if the table is not empty.
  - Added the required column `modelName` to the `GPU` table without a default value. This is not possible if the table is not empty.
  - Added the required column `cpuSocket` to the `Motherboard` table without a default value. This is not possible if the table is not empty.
  - Made the column `chipset` on table `Motherboard` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `capacityGb` to the `RAM` table without a default value. This is not possible if the table is not empty.
  - Added the required column `formFactor` to the `RAM` table without a default value. This is not possible if the table is not empty.
  - Added the required column `manufacturer` to the `RAM` table without a default value. This is not possible if the table is not empty.
  - Added the required column `memoryType` to the `RAM` table without a default value. This is not possible if the table is not empty.
  - Added the required column `modelName` to the `RAM` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "SlotInterface" AS ENUM ('PCIE_5_0', 'PCIE_4_0', 'PCIE_3_0', 'PCIE_2_0', 'OTHER');

-- CreateEnum
CREATE TYPE "MemoryType" AS ENUM ('DDR3', 'DDR4', 'DDR5', 'OTHER');

-- CreateEnum
CREATE TYPE "GMemoryType" AS ENUM ('GDDR3', 'GDDR4', 'GDDR5', 'GDDR5X', 'GDDR6', 'GDDR6X', 'GDDR7', 'HBM2', 'HBM2E', 'OTHER');

-- CreateEnum
CREATE TYPE "StorageType" AS ENUM ('M2', 'SATA', 'NVME', 'OTHER');

-- DropIndex
DROP INDEX "CPU_model_key";

-- AlterTable
ALTER TABLE "CPU" DROP COLUMN "brand",
DROP COLUMN "generation",
DROP COLUMN "model",
DROP COLUMN "socket",
ADD COLUMN     "aiAccelFeatures" TEXT,
ADD COLUMN     "architecture" TEXT NOT NULL DEFAULT 'Unknown',
ADD COLUMN     "baseClock" DOUBLE PRECISION NOT NULL DEFAULT 0.0,
ADD COLUMN     "boostClock" DOUBLE PRECISION,
ADD COLUMN     "cacheL1" INTEGER,
ADD COLUMN     "cacheL2" INTEGER,
ADD COLUMN     "cacheL3" INTEGER,
ADD COLUMN     "eCoreBaseFreq" DOUBLE PRECISION,
ADD COLUMN     "eCoreMaxFreq" DOUBLE PRECISION,
ADD COLUMN     "eccSupport" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "efficientCoreCount" INTEGER,
ADD COLUMN     "instructionExtensions" TEXT,
ADD COLUMN     "instructionSet" TEXT,
ADD COLUMN     "integratedGpuId" INTEGER,
ADD COLUMN     "launchDate" TIMESTAMP(3),
ADD COLUMN     "manufacturer" TEXT NOT NULL DEFAULT 'Unknown',
ADD COLUMN     "maxMemoryCapacity" DOUBLE PRECISION,
ADD COLUMN     "maxMemoryChannels" INTEGER,
ADD COLUMN     "maxTurboPower" DOUBLE PRECISION,
ADD COLUMN     "memoryType" "MemoryType",
ADD COLUMN     "modelName" TEXT NOT NULL DEFAULT 'Unknown',
ADD COLUMN     "notes" TEXT,
ADD COLUMN     "npuName" TEXT,
ADD COLUMN     "npuPeakTops" INTEGER,
ADD COLUMN     "npuSparsitySupport" BOOLEAN,
ADD COLUMN     "numberOfCores" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "numberOfThreads" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "overallPeakTops" INTEGER,
ADD COLUMN     "pCoreBaseFreq" DOUBLE PRECISION,
ADD COLUMN     "pCoreMaxFreq" DOUBLE PRECISION,
ADD COLUMN     "partNumber" TEXT,
ADD COLUMN     "pciExpressLanes" INTEGER,
ADD COLUMN     "performanceCoreCount" INTEGER,
ADD COLUMN     "processNode" TEXT,
ADD COLUMN     "securityFeatures" TEXT,
ADD COLUMN     "series" TEXT NOT NULL DEFAULT 'Unknown',
ADD COLUMN     "slotInterface" "SlotInterface",
ADD COLUMN     "socketType" TEXT NOT NULL DEFAULT 'Unknown',
ADD COLUMN     "unlocked" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "virtualizationSupport" TEXT,
ALTER COLUMN "tdp" SET DATA TYPE DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "GPU" DROP COLUMN "chipset",
DROP COLUMN "memory",
DROP COLUMN "model",
ADD COLUMN     "baseClockMHz" INTEGER,
ADD COLUMN     "boostClockMHz" INTEGER,
ADD COLUMN     "busInterface" "SlotInterface",
ADD COLUMN     "computeUnits" INTEGER,
ADD COLUMN     "cudaCores" INTEGER,
ADD COLUMN     "directXVersion" TEXT,
ADD COLUMN     "gpuEngine" TEXT,
ADD COLUMN     "heightMm" DOUBLE PRECISION,
ADD COLUMN     "lengthMm" DOUBLE PRECISION,
ADD COLUMN     "manufacturer" TEXT,
ADD COLUMN     "maxMonitors" INTEGER,
ADD COLUMN     "maxResolution" TEXT,
ADD COLUMN     "memoryBusWidth" INTEGER,
ADD COLUMN     "memorySizeGB" INTEGER NOT NULL,
ADD COLUMN     "memorySpeedGbps" DOUBLE PRECISION,
ADD COLUMN     "memoryType" "GMemoryType" NOT NULL,
ADD COLUMN     "modelName" TEXT NOT NULL,
ADD COLUMN     "multiGpuSupport" TEXT,
ADD COLUMN     "notes" TEXT,
ADD COLUMN     "openGLVersion" TEXT,
ADD COLUMN     "partNumber" TEXT,
ADD COLUMN     "powerConnectors" TEXT,
ADD COLUMN     "rayAccelerators" INTEGER,
ADD COLUMN     "recommendedPSU" INTEGER,
ADD COLUMN     "releaseDate" TIMESTAMP(3),
ADD COLUMN     "series" TEXT,
ADD COLUMN     "slotSize" DOUBLE PRECISION,
ADD COLUMN     "streamProcessors" INTEGER,
ADD COLUMN     "typicalBoardPower" INTEGER,
ADD COLUMN     "widthMm" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "Motherboard" DROP COLUMN "brand",
DROP COLUMN "model",
DROP COLUMN "socket",
ADD COLUMN     "bluetoothSupport" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "bluetoothVersion" TEXT,
ADD COLUMN     "cpuSocket" TEXT NOT NULL,
ADD COLUMN     "manufacturer" TEXT NOT NULL DEFAULT 'Unknown',
ADD COLUMN     "maxMemoryCapacity" INTEGER,
ADD COLUMN     "memorySlots" INTEGER,
ADD COLUMN     "memorySpeedNotes" TEXT,
ADD COLUMN     "memoryType" "MemoryType",
ADD COLUMN     "modelName" TEXT NOT NULL DEFAULT 'Unknown',
ADD COLUMN     "notes" TEXT,
ADD COLUMN     "partNumber" TEXT,
ADD COLUMN     "releaseDate" TIMESTAMP(3),
ADD COLUMN     "wifiSupport" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "wifiVersion" TEXT,
ALTER COLUMN "chipset" SET NOT NULL;

-- AlterTable
ALTER TABLE "RAM" DROP COLUMN "model",
DROP COLUMN "speed",
DROP COLUMN "type",
ADD COLUMN     "capacityGb" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "eccSupport" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "formFactor" TEXT NOT NULL,
ADD COLUMN     "heightMm" DOUBLE PRECISION,
ADD COLUMN     "kitSize" INTEGER NOT NULL DEFAULT 1,
ADD COLUMN     "latency" TEXT,
ADD COLUMN     "ledLighting" TEXT,
ADD COLUMN     "manufacturer" TEXT NOT NULL,
ADD COLUMN     "memoryType" "MemoryType" NOT NULL,
ADD COLUMN     "modelName" TEXT NOT NULL,
ADD COLUMN     "notes" TEXT,
ADD COLUMN     "partNumber" TEXT,
ADD COLUMN     "registeredUnbuffered" TEXT,
ADD COLUMN     "releaseDate" TIMESTAMP(3),
ADD COLUMN     "series" TEXT,
ADD COLUMN     "speedMt" INTEGER,
ADD COLUMN     "voltage" DOUBLE PRECISION,
ALTER COLUMN "brand" DROP NOT NULL;

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
CREATE TABLE "GPUVideoOutput" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "version" TEXT,
    "portCount" INTEGER NOT NULL,
    "notes" TEXT,
    "gpuId" INTEGER NOT NULL,

    CONSTRAINT "GPUVideoOutput_pkey" PRIMARY KEY ("id")
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
