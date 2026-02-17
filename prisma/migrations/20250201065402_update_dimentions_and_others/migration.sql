/*
  Warnings:

  - You are about to drop the column `dimensions` on the `ComputerCase` table. All the data in the column will be lost.
  - The `gpuClearance` column on the `ComputerCase` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `cpuCoolerClearance` column on the `ComputerCase` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `slotSize` on the `GPU` table. All the data in the column will be lost.
  - You are about to drop the column `heightMm` on the `RAM` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[includedCoolerId]` on the table `CPU` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "CPU" ADD COLUMN     "includedCoolerId" INTEGER;

-- AlterTable
ALTER TABLE "ComputerCase" DROP COLUMN "dimensions",
ADD COLUMN     "height" DOUBLE PRECISION,
ADD COLUMN     "length" DOUBLE PRECISION,
ADD COLUMN     "width" DOUBLE PRECISION,
DROP COLUMN "gpuClearance",
ADD COLUMN     "gpuClearance" DOUBLE PRECISION,
DROP COLUMN "cpuCoolerClearance",
ADD COLUMN     "cpuCoolerClearance" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "Fan" ADD COLUMN     "cpuCoolerId" INTEGER;

-- AlterTable
ALTER TABLE "GPU" DROP COLUMN "slotSize";

-- AlterTable
ALTER TABLE "Motherboard" ADD COLUMN     "height" DOUBLE PRECISION,
ADD COLUMN     "length" DOUBLE PRECISION,
ADD COLUMN     "width" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "RAM" DROP COLUMN "heightMm";

-- CreateTable
CREATE TABLE "PSUCable" (
    "id" SERIAL NOT NULL,
    "quantity" INTEGER NOT NULL,
    "cableName" TEXT NOT NULL,
    "connectorsPerCable" INTEGER NOT NULL,
    "totalConnectors" INTEGER NOT NULL,
    "connectorSpacing" TEXT,
    "totalLength" TEXT NOT NULL,
    "cableType" TEXT NOT NULL,
    "psuId" INTEGER NOT NULL,

    CONSTRAINT "PSUCable_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CPUCooler" (
    "id" SERIAL NOT NULL,
    "manufacturer" TEXT NOT NULL,
    "modelName" TEXT NOT NULL,
    "type" TEXT,
    "lcdDiameter" DOUBLE PRECISION,
    "lcdColors" TEXT,
    "lcdResolution" TEXT,
    "lcdBrightness" DOUBLE PRECISION,
    "lcdPanelType" TEXT,
    "lcdRefreshRate" DOUBLE PRECISION,
    "lcdOrientation" TEXT,
    "pumpName" TEXT,
    "pumpMotorSpeedMin" INTEGER,
    "pumpMotorSpeedMax" INTEGER,
    "pumpMotorVariance" INTEGER,
    "pumpPower" DOUBLE PRECISION,
    "capDiameter" DOUBLE PRECISION,
    "capHeight" DOUBLE PRECISION,
    "capMaterial" TEXT,
    "capRingMaterial" TEXT,
    "capColdPlateMaterial" TEXT,
    "capHousingMaterial" TEXT,
    "radiatorLength" DOUBLE PRECISION,
    "radiatorWidth" DOUBLE PRECISION,
    "radiatorHeight" DOUBLE PRECISION,
    "radiatorMaterial" TEXT,
    "tubingLength" DOUBLE PRECISION,
    "tubingMaterial" TEXT,
    "socketSupport" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "length" DOUBLE PRECISION,
    "width" DOUBLE PRECISION,
    "height" DOUBLE PRECISION,
    "partNumber" TEXT NOT NULL,
    "notes" TEXT,
    "photo" TEXT,

    CONSTRAINT "CPUCooler_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "CPU_includedCoolerId_key" ON "CPU"("includedCoolerId");

-- AddForeignKey
ALTER TABLE "CPU" ADD CONSTRAINT "CPU_includedCoolerId_fkey" FOREIGN KEY ("includedCoolerId") REFERENCES "CPUCooler"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PSUCable" ADD CONSTRAINT "PSUCable_psuId_fkey" FOREIGN KEY ("psuId") REFERENCES "PSU"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Fan" ADD CONSTRAINT "Fan_cpuCoolerId_fkey" FOREIGN KEY ("cpuCoolerId") REFERENCES "CPUCooler"("id") ON DELETE SET NULL ON UPDATE CASCADE;
