-- CreateTable
CREATE TABLE "CPU" (
    "id" SERIAL NOT NULL,
    "brand" TEXT NOT NULL,
    "model" TEXT NOT NULL,
    "socket" TEXT NOT NULL,
    "generation" TEXT,
    "tdp" INTEGER,

    CONSTRAINT "CPU_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Motherboard" (
    "id" SERIAL NOT NULL,
    "brand" TEXT NOT NULL,
    "model" TEXT NOT NULL,
    "socket" TEXT NOT NULL,
    "chipset" TEXT,
    "formFactor" TEXT,

    CONSTRAINT "Motherboard_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GPU" (
    "id" SERIAL NOT NULL,
    "brand" TEXT NOT NULL,
    "model" TEXT NOT NULL,
    "chipset" TEXT NOT NULL,
    "memory" INTEGER,

    CONSTRAINT "GPU_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RAM" (
    "id" SERIAL NOT NULL,
    "brand" TEXT NOT NULL,
    "model" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "speed" INTEGER,

    CONSTRAINT "RAM_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PreBuild" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "cpuId" INTEGER NOT NULL,
    "moboId" INTEGER NOT NULL,
    "gpuId" INTEGER,
    "ramId" INTEGER,

    CONSTRAINT "PreBuild_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "PreBuild" ADD CONSTRAINT "PreBuild_cpuId_fkey" FOREIGN KEY ("cpuId") REFERENCES "CPU"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PreBuild" ADD CONSTRAINT "PreBuild_moboId_fkey" FOREIGN KEY ("moboId") REFERENCES "Motherboard"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PreBuild" ADD CONSTRAINT "PreBuild_gpuId_fkey" FOREIGN KEY ("gpuId") REFERENCES "GPU"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PreBuild" ADD CONSTRAINT "PreBuild_ramId_fkey" FOREIGN KEY ("ramId") REFERENCES "RAM"("id") ON DELETE SET NULL ON UPDATE CASCADE;
