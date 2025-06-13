# Bluelry API

Backend Ruby on Rails de l'application e-commerce [Bluelry](https://www.bluelry.com). Architecture API-only, sécurisée et prête pour la production, avec un déploiement Capistrano/Puma sur VPS Linux.

---

## 🚀 Stack technique

- **Rails 7 (API-only)** – structure légère, RESTful
- **MySQL** – base de données relationnelle
- **Devise + JWT** – auth sécurisée par token
- **Pundit** – autorisations par rôle
- **Stripe** – paiement en ligne (Payment Intents)
- **Rack::Attack** – protection anti-abus/dos
- **Capistrano + Puma** – déploiement + gestion des workers

---

## 🔐 Authentification

- Auth via `Devise` + `devise-jwt`
- Endpoints :
  - `POST /users/sign_in` / `sign_out`
  - `GET /users/me`
  - Tokens dans les headers HTTP `Authorization`

---

## 🧩 Fonctionnalités de l’API

- 📦 **Produits** : CRUD produit complet
- 👤 **Utilisateurs** : liste, profil
- 🛒 **Panier** :
  - `POST /cart/add_item`
  - `DELETE /cart/remove_item`
  - `DELETE /cart/clear`
- 🧾 **Commandes**
- 💳 **Paiement Stripe** :
  - `POST /create-payment-intent` → renvoie un `client_secret` pour le front

---

## 🛠️ Lancer localement

```bash
git clone https://github.com/ayoub-sourrakh/bluelry_api.git
cd bluelry_api
bundle install
cp config/database.yml.example config/database.yml
rails db:create db:migrate
rails s
