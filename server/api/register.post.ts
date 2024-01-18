import { z } from 'zod'
import { PrismaClient } from '@prisma/client'
import bcrypt from 'bcrypt'

const prisma = new PrismaClient()

const registerSchema = z
  .object({
    name: z.string().min(2),
    email: z.string().email(),
    password: z.string().min(6),
    confirmPassword: z.string().min(6),
  })
  .refine(data => data.password === data.confirmPassword, {
    message: "Passwords don't match",
    path: ['confirmPassword'],
  })

export default defineEventHandler(async event => {
  const validated = await readValidatedBody(event, body =>
    registerSchema.safeParse(body),
  )

  if (!validated.success)
    throw createError({
      statusCode: 400,
      statusMessage: 'Validation error',
    })

  const { name, email, password } = validated.data

  const existingUser = await prisma.user.findUnique({ where: { email } })
  if (existingUser) {
    throw createError({
      statusCode: 400,
      statusMessage: 'User already exists',
    })
  }

  const hashedPassword = await bcrypt.hash(password, 10)

  const newUser = await prisma.user.create({
    data: {
      name,
      email,
      password: hashedPassword,
    },
  })

  return { message: 'User registered successfully', user: newUser }
})
