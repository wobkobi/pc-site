/*
  Warnings:

  - A unique constraint covering the columns `[model]` on the table `CPU` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "CPU_model_key" ON "CPU"("model");
