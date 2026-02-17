import { prisma } from '@/lib/prisma';
import { notFound } from 'next/navigation';
import Link from 'next/link';

type Props = {
  params: {
    prebuildId: string;
  };
};

export default async function PrebuildDetail({ params }: Props) {
  const prebuildId = parseInt(params.prebuildId, 10);
  if (!prebuildId) return notFound();

  const prebuild = await prisma.preBuild.findUnique({
    where: { id: prebuildId },
    include: {
      cpu: true,
      motherboard: true,
      gpu: true,
      ram: true,
    },
  });
  if (!prebuild) return notFound();

  return (
    <div>
      <h1>Pre-Build: {prebuild.name}</h1>
      <p>
        CPU: {prebuild.cpu.manufacturer} {prebuild.cpu.modelName}
      </p>
      <p>
        Mobo: {prebuild.motherboard.manufacturer} {prebuild.motherboard.modelName}
      </p>
      {prebuild.gpu && (
        <p>
          GPU: {prebuild.gpu.brand} {prebuild.gpu.modelName}
        </p>
      )}
      {prebuild.ram && (
        <p>
          RAM: {prebuild.ram.manufacturer} {prebuild.ram.modelName}
        </p>
      )}
      <Link
        href={`/build?cpuId=${prebuild.cpuId}&moboId=${prebuild.moboId}&gpuId=${
          prebuild.gpuId || ""
        }&ramId=${prebuild.ramId || ""}`}
      >
        <button>Customize</button>
      </Link>
    </div>
  );
}
