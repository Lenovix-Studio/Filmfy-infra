# Agent Context - Filmfy

Ini adalah ringkasan konteks dari project **Filmfy** berdasarkan analisis direktori `frontend`, `backend`, dan `infra`.

## Gambaran Umum (Overview)
**Filmfy** adalah sebuah proyek yang tampaknya berupa aplikasi terkait film (seperti yang ditunjukkan oleh namanya dan adanya modul "genres" di sisi backend). Proyek ini menggunakan arsitektur modern yang terbagi menjadi tiga bagian utama: frontend, backend, dan infrastruktur (infra).

## Struktur & Stack Teknologi

### 1. Frontend (`/frontend`)
Frontend merupakan aplikasi antarmuka pengguna berbasis web modern.
- **Framework Utama**: Next.js (v16.3.0) & React (v19)
- **Styling & UI**: Tailwind CSS (v4), Shadcn UI, Base UI, clsx, tailwind-merge, tw-animate-css
- **State Management & Data Fetching**: Zustand, React Query (@tanstack/react-query), Axios
- **Form & Validasi**: React Hook Form, Zod, @hookform/resolvers
- **Lain-lain**: Lucide React (ikon), Next Themes (tema warna), Sonner (notifikasi toast)

### 2. Backend (`/backend`)
Backend merupakan aplikasi REST API yang kuat dan terstruktur.
- **Framework Utama**: NestJS (v11) yang berjalan di atas Fastify (menggantikan default Express)
- **Database & ORM**: PostgreSQL, Prisma ORM
- **Autentikasi & Keamanan**: JWT (@nestjs/jwt), Passport, bcrypt (hashing)
- **Validasi Data**: class-validator, class-transformer
- **Dokumentasi API**: Swagger (@nestjs/swagger)
- **Utilitas**: Sharp (untuk pemrosesan gambar)
- Terdapat catatan pengembangan MVP, contohnya modul `genres` (master genre). Skrip di `package.json` juga menyiapkan environment `.env.dev` dan `.env` (production).

### 3. Infra (`/infra`)
Direktori ini memuat konfigurasi layanan infrastruktur, utamanya dengan Docker.
- **Docker Compose**: Dikonfigurasi untuk menjalankan dua kontainer database PostgreSQL (menggunakan image `postgres:17-alpine`):
  - `postgres-dev`: Berjalan untuk development di port `6020`.
  - `postgres-prod`: Berjalan untuk production di port `6021`.
- Manajemen volume data lokal, variabel environment, dan skrip inisialisasi diletakkan di dalam folder `data`, `env`, dan `script`.

## Rules (Aturan yang Disepakati)
Saat berinteraksi atau melakukan tugas dalam repositori ini, aturan berikut akan dipatuhi:
- **Jangan** otomatis melakukan `commit` atau `push` ke repository (seperti git push).
- **Diperbolehkan** melakukan perintah `build` atau *push database* secara otomatis, **hanya untuk environment dev**.
- **Diperbolehkan** untuk mengganti/mengedit isi file dan menyimpannya secara otomatis (sesuai instruksi task).
