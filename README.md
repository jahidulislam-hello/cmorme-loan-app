# Reverse Mortgage Loan App

A mobile application built with Flutter that helps users explore, calculate, and request reverse mortgage loan options. The app targets homeowners looking to leverage their home equity through reverse refinance or reverse-for-purchase programs.

---

## Overview

The Reverse Mortgage Loan App provides a guided experience for users to understand reverse mortgages, get instant loan calculations, and submit loan proposals — all from their mobile device. It connects to a backend API for real-time calculations, proposal submissions, and account management.

---

## Key Features

### Authentication
- User registration with email and password
- OTP-based email verification
- Secure login and logout
- Forgot password and reset password via OTP

### Loan Calculator
- **Reverse Refinance** — calculates loan eligibility based on home value, current mortgage balance, and borrower age
- **Reverse for Purchase** — calculates purchasing power for buyers using a reverse mortgage
- Supports single and co-borrower (married couple) scenarios
- Photo upload for property documentation
- Instant loan result summary

### Request a Proposal
- Multi-step guided form covering:
  - Basic personal information
  - Date of birth
  - Contact details (phone, address, city, state)
  - Loan amount and interest preferences
  - Appointment scheduling
- Tracks proposal submission and confirmation

### Profile Management
- View and edit personal profile
- Change password
- App settings

### Inbox
- In-app notifications and message center
- Detailed message view

### Education & Resources
- FAQ section
- Blog / articles
- Testimonials
- About Us
- Why We Educate section
- Instant Quote screen

### Legal
- In-app access to legal content (terms, policies)

### Recent Calculations
- History of past loan calculations
- View or delete individual calculation records

---

## Platform

- **Android** and **iOS**

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter |
| State Management | GetX |
| Networking | Dio |
| Local Storage | Hive, SharedPreferences |
| Connectivity | connectivity_plus |

---

## Getting Started

### Prerequisites
- Flutter SDK installed
- Android Studio or Xcode for platform builds

### Setup
1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Update the API base URL in `lib/core/constants/api_constants.dart`
4. Run the app with `flutter run`

---

## License

This project is proprietary. All rights reserved.
