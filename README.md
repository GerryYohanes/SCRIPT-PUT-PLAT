# 🧱 AUTO PUT PLAT

Script otomatis untuk menempatkan **platform (plat)** secara massal di world Growtopia. Cocok digunakan untuk proses pembangunan farming world seperti Dirt Farm, Pepper Farm, dan lainnya.

---

## ✨ Fitur Utama

* ♻️ **Penempatan Otomatis Platform**

  * Bot secara otomatis mengisi platform pada koordinat yang kosong (tile `fg == 0`).

* 📦 **Ambil Plat dari World Storage**

  * Jika platform di inventory habis, bot akan mengambil dari world storage yang sudah ditentukan.

* 🌐 **Multi-World Support**

  * Bisa digunakan untuk banyak world secara berurutan (`WorldPlat`).

* 📡 **Notifikasi Webhook**

  * Status bot akan dikirimkan melalui webhook Discord:

    * Saat mulai menaruh plat
    * Saat reconnecting
    * Saat world selesai diisi plat

* 🧠 **Deteksi Otomatis**

  * Bot akan mengecek apakah world sudah penuh plat atau masih ada tile kosong.

* 🚩 **Auto Stop Script**

  * Script akan berhenti otomatis setelah semua world dalam daftar selesai diproses.

---

## 🔧 Pengaturan Wajib

Di bagian atas script, kamu perlu mengatur:

```lua
WorldPlat = {"WORLD1", "WORLD2"} -- Daftar world yang ingin diisi plat
IdDoorWorldPlat = "ENTRANCE"       -- Nama pintu di setiap world
WorldStoragePlat = "STORAGEWORLD" -- World tempat penyimpanan plat
IdDoorStoragePlat = "PLATDOOR"     -- Nama pintu masuk storage
LinkWebhook = "https://discord.com/api/webhooks/..." -- Webhook Discord
```

---

## 🧹 Mekanisme Kerja

1. Bot warp ke world dari `WorldPlat`.
2. Cek semua tile target (pola X:1–98 dan Y:2–52 tiap 2 baris).
3. Jika ada tile kosong (fg == 0):

   * Cari dan tempatkan platform (ID 102).
   * Jika stok habis, bot akan warp ke `WorldStoragePlat` dan ambil dari sana.
4. Ulangi sampai world penuh dengan platform.
5. Kirim laporan ke Discord lewat webhook.
6. Lanjut ke world berikutnya.
7. Setelah semua selesai → `bot:stopScript()`.

---

## 📝 Contoh Log Webhook

```text
Bot : BotFarm01
Bot Status : Online
World : DIRTWORLDA
Status : Start Putting Plat
```

```text
Bot : BotFarm01
Bot Status : Online
World : DIRTWORLDA
Status : Done Putting Plat
```

---

## 🚰 Tips

* Pastikan item platform (ID 102) tersedia di `WorldStoragePlat`.
* Gunakan bot yang memiliki akses ke semua world dan tidak sedang di-lock player lain.
* Delay sudah diatur cukup cepat (`0.025`), namun kamu bisa modifikasi jika ingin lebih aman dari flood.

---
