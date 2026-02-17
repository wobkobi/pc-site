// lib/types.ts

export interface CPU {
    id: number;
    manufacturer: string;
    series: string;
    modelName: string;
    socketType: string;
    photo: string;
    partNumber: string;
  }
  
  export interface Motherboard {
    id: number;
    manufacturer: string;
    modelName: string;
    formFactor?: string;
    cpuSocket: string;
    photo: string;
    partNumber: string;
  }
  
  export interface GPU {
    id: number;
    brand: string;
    modelName: string;
    lengthMm?: number;
    photo: string;
    partNumber: string;
  }
  
  export interface RAM {
    id: number;
    manufacturer: string;
    modelName: string;
    memoryType: string;
    photo: string;
    partNumber: string;
  }
  
  export interface Storage {
    id: number;
    manufacturer: string;
    modelName: string;
    storageType: string;
    photo: string;
    partNumber: string;
  }
  
  export interface ComputerCase {
    id: number;
    manufacturer: string;
    modelName: string;
    motherboardSupport?: string;
    gpuClearance?: string;
    photo: string;
    partNumber: string;
  }
  
  export interface PSU {
    id: number;
    manufacturer: string;
    modelName: string;
    wattage: number;
    photo: string;
    partNumber: string;
  }
  