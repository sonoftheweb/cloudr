-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Projects" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Projects_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProjectUsers" (
    "id" SERIAL NOT NULL,
    "projectId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "isOwner" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProjectUsers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProjectAttributes" (
    "id" SERIAL NOT NULL,
    "projectId" TEXT NOT NULL,
    "settings" JSON NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProjectAttributes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProjectAssets" (
    "id" SERIAL NOT NULL,
    "projectId" TEXT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "key" VARCHAR(255) NOT NULL,
    "settings" JSON NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProjectAssets_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Projects_name_key" ON "Projects"("name");

-- CreateIndex
CREATE UNIQUE INDEX "ProjectAssets_name_key" ON "ProjectAssets"("name");

-- CreateIndex
CREATE UNIQUE INDEX "ProjectAssets_key_key" ON "ProjectAssets"("key");

-- AddForeignKey
ALTER TABLE "ProjectUsers" ADD CONSTRAINT "ProjectUsers_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Projects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectUsers" ADD CONSTRAINT "ProjectUsers_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectAttributes" ADD CONSTRAINT "ProjectAttributes_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Projects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectAssets" ADD CONSTRAINT "ProjectAssets_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Projects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
