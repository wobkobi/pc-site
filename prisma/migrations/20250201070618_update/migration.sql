/*
  Warnings:

  - The `photo` column on the `CPU` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `photo` column on the `CPUCooler` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `photo` column on the `ComputerCase` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `photo` column on the `Fan` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `photo` column on the `GPU` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `photo` column on the `Motherboard` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `photo` column on the `PSU` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `photo` column on the `RAM` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `photo` column on the `Storage` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "CPU" DROP COLUMN "photo",
ADD COLUMN     "photo" TEXT[] DEFAULT ARRAY[]::TEXT[];

-- AlterTable
ALTER TABLE "CPUCooler" DROP COLUMN "photo",
ADD COLUMN     "photo" TEXT[] DEFAULT ARRAY[]::TEXT[];

-- AlterTable
ALTER TABLE "ComputerCase" DROP COLUMN "photo",
ADD COLUMN     "photo" TEXT[] DEFAULT ARRAY[]::TEXT[];

-- AlterTable
ALTER TABLE "Fan" DROP COLUMN "photo",
ADD COLUMN     "photo" TEXT[] DEFAULT ARRAY[]::TEXT[];

-- AlterTable
ALTER TABLE "GPU" DROP COLUMN "photo",
ADD COLUMN     "photo" TEXT[] DEFAULT ARRAY[]::TEXT[];

-- AlterTable
ALTER TABLE "Motherboard" DROP COLUMN "photo",
ADD COLUMN     "photo" TEXT[] DEFAULT ARRAY[]::TEXT[];

-- AlterTable
ALTER TABLE "PSU" DROP COLUMN "photo",
ADD COLUMN     "photo" TEXT[] DEFAULT ARRAY[]::TEXT[];

-- AlterTable
ALTER TABLE "RAM" DROP COLUMN "photo",
ADD COLUMN     "photo" TEXT[] DEFAULT ARRAY[]::TEXT[];

-- AlterTable
ALTER TABLE "Storage" DROP COLUMN "photo",
ADD COLUMN     "photo" TEXT[] DEFAULT ARRAY[]::TEXT[];
