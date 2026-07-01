# Railway Deployment Guide para sa Latte and Letters

## 1. Railway MySQL Database Configuration

### Connection Details Mo:
- **Host:** hayabusa.proxy.rlwy.net
- **Port:** 18615
- **Username:** root
- **Password:** JAzgscTMSDFzQyetSZuiBDSVBscMVLOy
- **Database Name:** railway

## 2. I-Setup ang Database

### Option A: Via MySQL Command Line (Recommended)

Gamitin ang command na to para mag-connect:

```bash
mysql -h hayabusa.proxy.rlwy.net -u root -pJAzgscTMSDFzQyetSZuiBDSVBscMVLOy -P 18615
```

Once connected, i-create ang database:

```sql
-- Check existing databases
SHOW DATABASES;

-- Create database kung wala pa
CREATE DATABASE IF NOT EXISTS railway CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Use the database
USE railway;

-- Verify na empty pa
SHOW TABLES;
```

**Note:** Hindi mo na kailangan manually i-run ang schema.sql at demo-data.sql dahil automatic yan gagawin ng Spring Boot application mo via `DatabaseSchemaInitializer` at `DemoDataInitializer`.

### Option B: Via MySQL Workbench

1. Open MySQL Workbench
2. Create New Connection:
   - **Connection Name:** Railway - Latte and Letters
   - **Hostname:** hayabusa.proxy.rlwy.net
   - **Port:** 18615
   - **Username:** root
   - **Password:** JAzgscTMSDFzQyetSZuiBDSVBscMVLOy
3. Test Connection
4. Connect and create database:
   ```sql
   CREATE DATABASE IF NOT EXISTS railway CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```

## 3. Railway Environment Variables

Sa Railway Dashboard mo, i-set ang mga variables na ito:

### Required Database Variables:

```plaintext
LATTE_AND_LETTERS_DB_URL=jdbc:mysql://hayabusa.proxy.rlwy.net:18615/railway?useSSL=true&serverTimezone=Asia/Manila&allowPublicKeyRetrieval=true

LATTE_AND_LETTERS_DB_USERNAME=root

LATTE_AND_LETTERS_DB_PASSWORD=JAzgscTMSDFzQyetSZuiBDSVBscMVLOy
```

### Optional - Demo Data (kung gusto mo disabled sa production):

```plaintext
LATTE_AND_LETTERS_DEMO_DATA_ENABLED=false
```

### Optional - SMTP Configuration (para sa email notifications):

```plaintext
LATTE_AND_LETTERS_SMTP_HOST=smtp.gmail.com
LATTE_AND_LETTERS_SMTP_PORT=587
LATTE_AND_LETTERS_SMTP_USERNAME=your-email@gmail.com
LATTE_AND_LETTERS_SMTP_PASSWORD=your-app-password
LATTE_AND_LETTERS_SMTP_FROM=your-email@gmail.com
LATTE_AND_LETTERS_SMTP_SSL=true
```

### Optional - Storage Path (Railway uses ephemeral filesystem):

```plaintext
LATTE_AND_LETTERS_STORAGE_ROOT=/app/storage
```

## 4. Paano I-set ang Environment Variables sa Railway

### Via Railway Dashboard (Web UI):

1. Go to [railway.app](https://railway.app)
2. Select your project: **Latte and Letters**
3. Click on your service (yung Spring Boot app mo)
4. Click **"Variables"** tab sa left sidebar
5. Click **"New Variable"**
6. Copy-paste ang variables one by one:
   - Variable name: `LATTE_AND_LETTERS_DB_URL`
   - Value: `jdbc:mysql://hayabusa.proxy.rlwy.net:18615/railway?useSSL=true&serverTimezone=Asia/Manila&allowPublicKeyRetrieval=true`
7. Click **"Add"**
8. Repeat para sa lahat ng variables

### Via Railway CLI (Alternative):

```bash
# Install Railway CLI if wala pa
npm i -g @railway/cli

# Login
railway login

# Link to your project
railway link

# Set variables
railway variables set LATTE_AND_LETTERS_DB_URL="jdbc:mysql://hayabusa.proxy.rlwy.net:18615/railway?useSSL=true&serverTimezone=Asia/Manila&allowPublicKeyRetrieval=true"

railway variables set LATTE_AND_LETTERS_DB_USERNAME="root"

railway variables set LATTE_AND_LETTERS_DB_PASSWORD="JAzgscTMSDFzQyetSZuiBDSVBscMVLOy"
```

## 5. Deploy/Redeploy

Pagkatapos i-set ang variables:

1. **Automatic Redeploy:** Railway will automatically redeploy your app
2. **Manual Redeploy:** Click "Deploy" button sa Railway dashboard
3. **Via Git Push:** 
   ```bash
   git add .
   git commit -m "Configure Railway database"
   git push
   ```

## 6. Verify Deployment

### Check Logs:

1. Sa Railway dashboard, click **"Deployments"**
2. Click on the latest deployment
3. View **"Deploy Logs"**

Look for:
```
✓ Database schema initialized successfully
✓ Demo data loaded successfully
```

### Check Database:

```bash
mysql -h hayabusa.proxy.rlwy.net -u root -pJAzgscTMSDFzQyetSZuiBDSVBscMVLOy -P 18615 railway

# Then run:
SHOW TABLES;
SELECT COUNT(*) FROM books;
SELECT COUNT(*) FROM students;
```

### Test Application:

1. Open your Railway URL (e.g., `https://your-app.railway.app`)
2. Try logging in:
   - **Admin:** username: `admin`, password: `admin123`
   - **Student:** username: `alice`, password: `password`

## 7. Common Issues & Solutions

### Issue: "Access denied for user"
**Solution:** Double-check ang password sa environment variable. Walang typo.

### Issue: "Unknown database 'railway'"
**Solution:** I-create muna ang database using MySQL command line or Workbench.

### Issue: "SSL connection error"
**Solution:** Change `useSSL=true` to `useSSL=false` sa DB URL.

### Issue: Tables not created
**Solution:** Check deployment logs kung nag-run ba ang `DatabaseSchemaInitializer`. Kung hindi, i-check mo kung naka-set ba correctly ang `spring.jpa.hibernate.ddl-auto=none`.

### Issue: Demo data not loading
**Solution:** Set `LATTE_AND_LETTERS_DEMO_DATA_ENABLED=true` sa Railway variables.

## 8. Important Notes

⚠️ **Security:**
- Wag i-commit ang Railway password sa Git
- I-rotate ang password regularly
- Use environment variables palagi

⚠️ **Storage:**
- Railway uses ephemeral filesystem (nawawala pag redeploy)
- Para sa file uploads, gamitin ang cloud storage (AWS S3, Cloudinary, etc.)

⚠️ **Database Backups:**
- I-backup regularly ang Railway database
- Railway may have automatic backups, pero i-verify mo

## 9. Next Steps

1. ✅ Create database sa Railway MySQL
2. ✅ Set environment variables sa Railway
3. ✅ Deploy/Redeploy application
4. ✅ Verify tables were created
5. ✅ Test login functionality
6. ⬜ Configure custom domain (optional)
7. ⬜ Setup SSL certificate (optional, Railway provides by default)
8. ⬜ Monitor application logs

## 10. Useful Commands

### Connect to Railway MySQL:
```bash
mysql -h hayabusa.proxy.rlwy.net -u root -pJAzgscTMSDFzQyetSZuiBDSVBscMVLOy -P 18615 railway
```

### Export Local Database to Railway:
```bash
# Export from local
mysqldump -u root -p latte_and_letters > backup.sql

# Import to Railway
mysql -h hayabusa.proxy.rlwy.net -u root -pJAzgscTMSDFzQyetSZuiBDSVBscMVLOy -P 18615 railway < backup.sql
```

### View Railway Logs:
```bash
railway logs
```

---

**Need help?** Check Railway documentation: https://docs.railway.app/
