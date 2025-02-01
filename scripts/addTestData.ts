// addTestData.ts
import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function addTestData() {
  // Create a CPU
  const testCPU = await prisma.cPU.create({
    data: {
      manufacturer: "Intel",
      series: "Core Ultra Series",
      modelName: "Core Ultra 265",
      architecture: "Arrow Lake",
      launchDate: new Date("2025-01-01"),

      numberOfCores: 20,
      numberOfThreads: 20,
      performanceCoreCount: 8,
      efficientCoreCount: 12,

      baseClock: 2.4,   // GHz
      boostClock: 5.3,  // GHz

      tdp: 65,
      maxTurboPower: 182,

      cacheL1: 1280,  // in KB (example)
      cacheL2: 36,    // in MB
      cacheL3: 30,    // in MB

      processNode: "TSMC N3B",

      memoryType: "DDR5",
      maxMemoryChannels: 2,
      maxMemoryCapacity: 192,
      eccSupport: true,

      socketType: "LGA1851",
      unlocked: false,
      partNumber: "TEST-CPU-265",
      notes: "Test CPU" // marker for deletion
    }
  })
  console.log("Created CPU:", testCPU)

  // Create a GPU
  const testGPU = await prisma.gPU.create({
    data: {
      brand: "NVIDIA",
      manufacturer: "MSI",
      modelName: "RTX 4080 Ventus",
      series: "GeForce RTX 4000 Series",
      gpuEngine: "Ada Lovelace",

      cudaCores: 9728,
      baseClockMHz: 2200,
      boostClockMHz: 2500,

      memorySizeGB: 16,
      memoryType: "GDDR6X",
      memorySpeedGbps: 22,
      memoryBusWidth: 256, // example value

      busInterface: "PCIE_4_0",

      typicalBoardPower: 320,
      recommendedPSU: 750,

      maxResolution: "7680x4320",
      partNumber: "TEST-GPU-4080",
      notes: "Test GPU"
    }
  })
  console.log("Created GPU:", testGPU)

  // Create a Motherboard with various I/O details
  const testMobo = await prisma.motherboard.create({
    data: {
      manufacturer: "ASUS",
      modelName: "ROG Strix Z790-E Gaming",
      formFactor: "ATX",
      chipset: "Z790",
      cpuSocket: "LGA1851",

      memorySlots: 4,
      memoryType: "DDR5",
      maxMemoryCapacity: 128,
      memorySpeedNotes: "DDR5-6400 OC",

      // Wi-Fi and Bluetooth support (booleans + versions)
      wifiSupport: true,
      wifiVersion: "Wi-Fi 6E",
      bluetoothSupport: true,
      bluetoothVersion: "5.3",

      releaseDate: new Date("2024-12-01"),
      partNumber: "TEST-MOBO-Z790",
      notes: "Test Motherboard",

      // Create Ethernet ports
      ethernetPorts: {
        create: [
          { portCount: 1, speedGbps: 2.5, notes: "2.5GbE port" },
          { portCount: 1, speedGbps: 10, notes: "10GbE port" }
        ]
      },
      // Create USB ports (using a custom model for grouping)
      usbPorts: {
        create: [
          { usbStandard: "USB 2.0", portCount: 4, notes: "Rear USB 2.0" },
          { usbStandard: "USB 3.2 Gen2 Type-A", portCount: 2, notes: "Rear USB 3.2 Gen2" },
          { usbStandard: "USB 3.2 Gen2 Type-C", portCount: 1, notes: "Rear USB Type-C" }
        ]
      },
      // Create Video outputs
      videoOutputs: {
        create: [
          { outputType: "HDMI", version: "2.1", portCount: 1, notes: "HDMI port" },
          { outputType: "DisplayPort", version: "1.4a", portCount: 1, notes: "DisplayPort" }
        ]
      },
      // Create Audio jacks
      audioJacks: {
        create: [
          { jackType: "3.5mm", usage: "Line-out", portCount: 5, notes: "Front audio jacks" },
          { jackType: "S/PDIF", usage: "Optical", portCount: 1, notes: "Rear optical" }
        ]
      },
      // Create Internal Headers (fan headers, ARGB, etc.)
      internalHeaders: {
        create: [
          { headerType: "Fan Header", headerCount: 4, notes: "Chassis fan headers" },
          { headerType: "ARGB Header", headerCount: 2, notes: "RGB lighting" }
        ]
      }
    },
    include: {
      ethernetPorts: true,
      usbPorts: true,
      videoOutputs: true,
      audioJacks: true,
      internalHeaders: true
    }
  })
  console.log("Created Motherboard:", testMobo)

  // Create a RAM record
  const testRAM = await prisma.rAM.create({
    data: {
      brand: "Corsair",
      manufacturer: "Corsair",
      series: "Vengeance LPX",
      modelName: "CMK16GX4M2B3200C16",

      memoryType: "DDR4",
      formFactor: "UDIMM",
      capacityGb: 16,
      kitSize: 2,
      speedMt: 3200,
      voltage: 1.35,
      latency: "16-18-18-36",
      partNumber: "TEST-RAM-3200",
      notes: "Test RAM"
    }
  })
  console.log("Created RAM:", testRAM)

  // Create a PreBuild that references the above components
  const testPreBuild = await prisma.preBuild.create({
    data: {
      name: "Test PreBuild PC",
      cpuId: testCPU.id,
      moboId: testMobo.id,
      gpuId: testGPU.id,
      ramId: testRAM.id
    }
  })
  console.log("Created PreBuild:", testPreBuild)
}

addTestData()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (err) => {
    console.error(err)
    await prisma.$disconnect()
    process.exit(1)
  })
