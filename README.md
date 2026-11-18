# امیر ژورنال – نسخهٔ آنلاین + EXE

## ۱) دیتابیس و حساب‌ها (Supabase، پلن رایگان)
1. در supabase.com یک پروژه بساز.
2. SQL Editor → محتوای `schema.sql` را اجرا کن.
3. Project Settings → API: مقدار `Project URL` و `anon public key` را در بالای `<script>` فایل `index.html` به جای `YOUR-PROJECT` و `YOUR-ANON-PUBLIC-KEY` بگذار. (کلید `service_role` را هرگز داخل برنامه نگذار.)
4. Authentication → Providers → Email: اگر نمی‌خواهی تایید ایمیل لازم باشد، «Confirm email» را خاموش کن.
5. در برنامه با ایمیل خودت ثبت‌نام کن، بعد در SQL Editor: `update public.profiles set is_admin=true where email='ایمیل تو';` — از این به بعد تب 🛡 Admin را می‌بینی.

## ۲) ساخت فایل EXE (روی ویندوز، با Node.js نصب‌شده)
```
npm install
npm run dist
```
فایل نصبی در پوشهٔ `dist` ساخته می‌شود. (برای تست بدون ساخت: `npm start`)

## ۳) نسخهٔ وب
همین `index.html` را روی Netlify / Vercel / GitHub Pages آپلود کن تا از هر مرورگری قابل استفاده باشد. آدرس آن را در Supabase → Authentication → URL Configuration → Site URL بگذار تا لینک بازیابی رمز به آن برگردد.
