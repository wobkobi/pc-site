/*
  Warnings:

  - You are about to drop the column `height` on the `CPUCooler` table. All the data in the column will be lost.
  - You are about to drop the column `length` on the `CPUCooler` table. All the data in the column will be lost.
  - You are about to drop the column `radiatorHeight` on the `CPUCooler` table. All the data in the column will be lost.
  - You are about to drop the column `radiatorLength` on the `CPUCooler` table. All the data in the column will be lost.
  - You are about to drop the column `radiatorMaterial` on the `CPUCooler` table. All the data in the column will be lost.
  - You are about to drop the column `radiatorWidth` on the `CPUCooler` table. All the data in the column will be lost.
  - You are about to drop the column `tubingLength` on the `CPUCooler` table. All the data in the column will be lost.
  - You are about to drop the column `width` on the `CPUCooler` table. All the data in the column will be lost.
  - You are about to drop the column `fanSupport` on the `ComputerCase` table. All the data in the column will be lost.
  - You are about to drop the column `height` on the `ComputerCase` table. All the data in the column will be lost.
  - You are about to drop the column `length` on the `ComputerCase` table. All the data in the column will be lost.
  - You are about to drop the column `radiatorSupport` on the `ComputerCase` table. All the data in the column will be lost.
  - You are about to drop the column `width` on the `ComputerCase` table. All the data in the column will be lost.
  - The `motherboardSupport` column on the `ComputerCase` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `ioPorts` column on the `ComputerCase` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `height` on the `Motherboard` table. All the data in the column will be lost.
  - You are about to drop the column `length` on the `Motherboard` table. All the data in the column will be lost.
  - You are about to drop the column `width` on the `Motherboard` table. All the data in the column will be lost.
  - You are about to drop the column `totalLength` on the `PSUCable` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "MotherboardSupport" AS ENUM ('ATX', 'MicroATX', 'MiniITX', 'EATX', 'SSI_EEB');

-- CreateEnum
CREATE TYPE "FanPosition" AS ENUM ('FRONT', 'BACK', 'TOP', 'BOTTOM', 'SIDE', 'OTHER');

-- AlterTable
ALTER TABLE "CPUCooler" DROP COLUMN "height",
DROP COLUMN "length",
DROP COLUMN "radiatorHeight",
DROP COLUMN "radiatorLength",
DROP COLUMN "radiatorMaterial",
DROP COLUMN "radiatorWidth",
DROP COLUMN "tubingLength",
DROP COLUMN "width",
ADD COLUMN     "heightmm" DOUBLE PRECISION,
ADD COLUMN     "lengthmm" DOUBLE PRECISION,
ADD COLUMN     "tubingLengthmm" DOUBLE PRECISION,
ADD COLUMN     "widthmm" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "ComputerCase" DROP COLUMN "fanSupport",
DROP COLUMN "height",
DROP COLUMN "length",
DROP COLUMN "radiatorSupport",
DROP COLUMN "width",
ADD COLUMN     "heightmm" DOUBLE PRECISION,
ADD COLUMN     "lengthmm" DOUBLE PRECISION,
ADD COLUMN     "widthmm" DOUBLE PRECISION,
DROP COLUMN "motherboardSupport",
ADD COLUMN     "motherboardSupport" "MotherboardSupport",
DROP COLUMN "ioPorts",
ADD COLUMN     "ioPorts" JSONB;

-- AlterTable
ALTER TABLE "Motherboard" DROP COLUMN "height",
DROP COLUMN "length",
DROP COLUMN "width",
ADD COLUMN     "heightmm" DOUBLE PRECISION,
ADD COLUMN     "lengthmm" DOUBLE PRECISION,
ADD COLUMN     "widthmm" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "PSUCable" DROP COLUMN "totalLength",
ADD COLUMN     "totalLengthmm" TEXT NOT NULL DEFAULT '0mm';

-- CreateTable
CREATE TABLE "CaseFanSupport" (
    "id" SERIAL NOT NULL,
    "position" "FanPosition" NOT NULL,
    "sizeMm" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL,
    "computerCaseId" INTEGER NOT NULL,

    CONSTRAINT "CaseFanSupport_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CaseRadiatorSupport" (
    "id" SERIAL NOT NULL,
    "radiatorLengthMm" INTEGER NOT NULL,
    "fanCount" INTEGER NOT NULL,
    "computerCaseId" INTEGER NOT NULL,

    CONSTRAINT "CaseRadiatorSupport_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "CaseFanSupport" ADD CONSTRAINT "CaseFanSupport_computerCaseId_fkey" FOREIGN KEY ("computerCaseId") REFERENCES "ComputerCase"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CaseRadiatorSupport" ADD CONSTRAINT "CaseRadiatorSupport_computerCaseId_fkey" FOREIGN KEY ("computerCaseId") REFERENCES "ComputerCase"("id") ON DELETE CASCADE ON UPDATE CASCADE;
