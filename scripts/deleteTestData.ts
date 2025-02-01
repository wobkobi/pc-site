// scripts/deleteTestData.ts
import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function deleteTestData() {
  // Delete PreBuild records with names containing "Test PreBuild"
  const deletedPreBuilds = await prisma.preBuild.deleteMany({
    where: { name: { startsWith: "Test PreBuild" } }
  });
  console.log(`Deleted ${deletedPreBuilds.count} PreBuild record(s).`);

  // Delete CPUCooler records with partNumber starting with "TEST-CPUCOOLER-"
  const deletedCoolers = await prisma.cPUCooler.deleteMany({
    where: { partNumber: { startsWith: "TEST-CPUCOOLER-" } }
  });
  console.log(`Deleted ${deletedCoolers.count} CPUCooler record(s).`);

  // Delete Fan records with partNumber starting with "TEST-FAN-"
  const deletedFans = await prisma.fan.deleteMany({
    where: { partNumber: { startsWith: "TEST-FAN-" } }
  });
  console.log(`Deleted ${deletedFans.count} Fan record(s).`);

  // Delete PSUCable records with cableName starting with "TEST-CABLE-"
  const deletedCables = await prisma.pSUCable.deleteMany({
    where: { cableName: { startsWith: "TEST-CABLE-" } }
  });
  console.log(`Deleted ${deletedCables.count} PSUCable record(s).`);

  // Delete PSU records with partNumber starting with "TEST-PSU-"
  const deletedPSUs = await prisma.pSU.deleteMany({
    where: { partNumber: { startsWith: "TEST-PSU-" } }
  });
  console.log(`Deleted ${deletedPSUs.count} PSU record(s).`);

  // Delete ComputerCase records with partNumber starting with "TEST-CASE-"
  const deletedCases = await prisma.computerCase.deleteMany({
    where: { partNumber: { startsWith: "TEST-CASE-" } }
  });
  console.log(`Deleted ${deletedCases.count} ComputerCase record(s).`);

  // Delete Storage records with partNumber starting with "TEST-STORAGE-"
  const deletedStorage = await prisma.storage.deleteMany({
    where: { partNumber: { startsWith: "TEST-STORAGE-" } }
  });
  console.log(`Deleted ${deletedStorage.count} Storage record(s).`);

  // Delete RAM records with partNumber starting with "TEST-RAM-"
  const deletedRAMs = await prisma.rAM.deleteMany({
    where: { partNumber: { startsWith: "TEST-RAM-" } }
  });
  console.log(`Deleted ${deletedRAMs.count} RAM record(s).`);

  // Delete GPU records with partNumber starting with "TEST-GPU-"
  const deletedGPUs = await prisma.gPU.deleteMany({
    where: { partNumber: { startsWith: "TEST-GPU-" } }
  });
  console.log(`Deleted ${deletedGPUs.count} GPU record(s).`);

  // Delete Motherboard records with partNumber starting with "TEST-MOBO-"
  const deletedMobos = await prisma.motherboard.deleteMany({
    where: { partNumber: { startsWith: "TEST-MOBO-" } }
  });
  console.log(`Deleted ${deletedMobos.count} Motherboard record(s).`);

  // Delete CPU records with partNumber starting with "TEST-CPU-"
  const deletedCPUs = await prisma.cPU.deleteMany({
    where: { partNumber: { startsWith: "TEST-CPU-" } }
  });
  console.log(`Deleted ${deletedCPUs.count} CPU record(s).`);
}

deleteTestData()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (error) => {
    console.error(error);
    await prisma.$disconnect();
    process.exit(1);
  });
