# TodoApp - Flutter Task Manager

A beautiful, cross-platform task management app built with Flutter and Supabase, featuring authentication, real-time sync, and offline support.

## ✨ Features

- 🔐 **Secure Authentication** (Email/Password)
- ✅ **Task Management** (Create, Read, Update, Delete)
- 📅 **Due Date Tracking** with smart reminders
- 🏷️ **Priority & Status** (High/Medium/Low, Complete/Incomplete)
- 🌙 **Dark/Light Theme** support
- 📱 **Responsive Design** for mobile & tablet
- 🔄 **Real-time Sync** with Supabase backend
- ⚡ **Offline Support** with local SQLite cache

## 🚀 Tech Stack

- **Frontend**: Flutter 3.x
- **Backend**: [Supabase](https://supabase.io) (PostgreSQL + Auth + Storage)
- **State Management**: GetX
- **Local Database**: SQLite (sqflite)
- **Testing**: flutter_test + Mockito


## 🛠️ Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/alioshriyeh/TodoApp.git
   cd taskflow
   flutter pub get
   flutter run --android