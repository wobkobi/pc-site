// welcome page
import Link from "next/link";
import React from "react";

export default function Page() {
  return (
    <div>
      <h1>Welcome to the app</h1>
      <Link href="/about">About</Link>
    </div>
  );
}
