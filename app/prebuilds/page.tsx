import { prisma } from '@/lib/prisma';
import Link from 'next/link';

export default async function PrebuildsList() {
  const prebuilds = await prisma.preBuild.findMany({
    include: {
      cpu: true,
      motherboard: true,
      gpu: true,
      ram: true,
    },
  });

  return (
    <div>
      <h1>Pre-Built PCs</h1>
      {prebuilds.map((pb) => (
        <div
          key={pb.id}
          style={{ border: '1px solid #ccc', margin: '1rem', padding: '1rem' }}
        >
          <h2>{pb.name}</h2>
          <p>
            CPU: {pb.cpu.manufacturer} {pb.cpu.modelName}
          </p>
          <p>
            Mobo: {pb.motherboard.manufacturer} {pb.motherboard.modelName}
          </p>
          {pb.gpu && (
            <p>
              GPU: {pb.gpu.brand} {pb.gpu.modelName}
            </p>
          )}
          {pb.ram && (
            <p>
              RAM: {pb.ram.manufacturer} {pb.ram.modelName}
            </p>
          )}
          <Link href={`/prebuilds/${pb.id}`}>
            <button>View / Customize</button>
          </Link>
        </div>
      ))}
    </div>
  );
}
