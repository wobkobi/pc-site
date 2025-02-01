// deleteTestData.ts
import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function deleteTestData() {
  // Delete PreBuilds that reference our test data (based on the name marker)
  const deletedPreBuilds = await prisma.preBuild.deleteMany({
    where: {
      name: {
        contains: "Test PreBuild"
      }
    }
  })
  console.log(`Deleted ${deletedPreBuilds.count} PreBuild records.`)

  // Delete CPU records with test marker
  const deletedCPUs = await prisma.cPU.deleteMany({
    where: {
      notes: "Test CPU"
    }
  })
  console.log(`Deleted ${deletedCPUs.count} CPU records.`)

  // Delete GPU records with test marker
  const deletedGPUs = await prisma.gPU.deleteMany({
    where: {
      notes: "Test GPU"
    }
  })
  console.log(`Deleted ${deletedGPUs.count} GPU records.`)

  // Delete RAM records with test marker
  const deletedRAMs = await prisma.rAM.deleteMany({
    where: {
      notes: "Test RAM"
    }
  })
  console.log(`Deleted ${deletedRAMs.count} RAM records.`)

  // Delete Motherboard records with test marker
  const deletedMobos = await prisma.motherboard.deleteMany({
    where: {
      notes: "Test Motherboard"
    }
  })
  console.log(`Deleted ${deletedMobos.count} Motherboard records.`)

  // If there are any orphaned child records, they should be removed via onDelete: Cascade,
  // or you can delete them manually (example for EthernetPorts below):

  const deletedEthernetPorts = await prisma.ethernetPort.deleteMany({
    where: {
      motherboard: {
        notes: "Test Motherboard"
      }
    }
  })
  console.log(`Deleted ${deletedEthernetPorts.count} Ethernet port records.`)

  // Similarly, you can delete USB, Video, Audio, and Internal Header records if needed.
  // Here we assume they are removed via cascade on motherboard deletion.
}

deleteTestData()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (err) => {
    console.error(err)
    await prisma.$disconnect()
    process.exit(1)
  })
