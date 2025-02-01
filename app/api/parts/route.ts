// app/api/parts/route.ts
import { prisma } from '@/lib/prisma';
import { NextRequest, NextResponse } from 'next/server';

export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url);
  const type = searchParams.get('type'); // e.g., 'cpu', 'motherboard', etc.
  
  try {
    switch (type) {
      case 'cpu':
        return NextResponse.json(await prisma.cPU.findMany());
      case 'motherboard':
        return NextResponse.json(await prisma.motherboard.findMany());
      case 'gpu':
        return NextResponse.json(await prisma.gPU.findMany());
      case 'ram':
        return NextResponse.json(await prisma.rAM.findMany());
      case 'storage':
        return NextResponse.json(await prisma.storage.findMany());
      case 'computerCase':
        return NextResponse.json(await prisma.computerCase.findMany());
      case 'psu':
        return NextResponse.json(await prisma.pSU.findMany());
      case 'fan':
        return NextResponse.json(await prisma.fan.findMany());
      default:
        return NextResponse.json({ error: 'Unknown type query param' }, { status: 400 });
    }
  } catch (error: any) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
