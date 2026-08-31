import nodemailer from 'nodemailer'

export default defineEventHandler(async (event) => {
  try {
    const body = await readBody(event)

    const { nom, email, service, message, website } = body

    // 🛡 Anti-spam (honeypot)
    if (website) {
      return { success: true } // bot ignoré
    }

    // ✅ Validation
    if (!nom || !email || !service || !message) {
      return { success: false, error: 'Champs manquants' }
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    if (!emailRegex.test(email)) {
      return { success: false, error: 'Email invalide' }
    }

    // 📩 Transport SMTP
    const transporter = nodemailer.createTransport({
      host: process.env.SMTP_HOST,
      port: Number(process.env.SMTP_PORT),
      secure: true, // true si 465
      auth: {
        user: process.env.SMTP_USER,
        pass: process.env.SMTP_PASS
      }
    })

    // ✉️ Email HTML PREMIUM
    const html = `
      <div style="font-family: Arial, sans-serif; padding:20px; background:#f9fafb;">
        <h2 style="color:#111;">📩 Nouveau message MR INFRA</h2>

        <p><strong>Nom :</strong> ${nom}</p>
        <p><strong>Email :</strong> ${email}</p>
        <p><strong>Service :</strong> ${service}</p>

        <hr style="margin:20px 0;" />

        <p><strong>Message :</strong></p>
        <p style="background:#fff; padding:15px; border-radius:8px;">
          ${message}
        </p>

        <hr style="margin:20px 0;" />

        <p style="font-size:12px; color:#888;">
          Envoyé depuis le site MR INFRA
        </p>
      </div>
    `

    // 📤 Envoi
    await transporter.sendMail({
      from: `"MR INFRA" <${process.env.SMTP_FROM}>`,
      to: process.env.SMTP_TO, // ton email
      subject: `Nouveau message de ${nom}`,
      replyTo: email,
      html
    })

    return { success: true }

  } catch (error) {
    console.error('❌ EMAIL ERROR:', error)

    return {
      success: false,
      error: 'Erreur serveur'
    }
  }
})