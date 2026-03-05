#!/bin/bash

# UniAct – Feature-based folder structure scaffold
# Run from the project root: bash scaffold.sh

LIB="lib"

# ── core ──────────────────────────────────────────────────────────────────────
mkdir -p $LIB/core/constants
mkdir -p $LIB/core/theme
mkdir -p $LIB/core/utils
mkdir -p $LIB/core/widgets
mkdir -p $LIB/core/router

touch $LIB/core/constants/app_constants.dart
touch $LIB/core/theme/app_theme.dart
touch $LIB/core/utils/app_utils.dart
touch $LIB/core/router/app_router.dart

# ── models ────────────────────────────────────────────────────────────────────
mkdir -p $LIB/models

touch $LIB/models/task_model.dart
touch $LIB/models/session_model.dart
touch $LIB/models/user_model.dart

# ── services ──────────────────────────────────────────────────────────────────
mkdir -p $LIB/services

touch $LIB/services/api_service.dart
touch $LIB/services/task_service.dart
touch $LIB/services/session_service.dart
touch $LIB/services/storage_service.dart

# ── features/home (Today Screen) ──────────────────────────────────────────────
mkdir -p $LIB/features/home/screens
mkdir -p $LIB/features/home/widgets
mkdir -p $LIB/features/home/providers

touch $LIB/features/home/screens/home_screen.dart
touch $LIB/features/home/providers/home_provider.dart

# ── features/task (Create/Edit + Detail) ──────────────────────────────────────
mkdir -p $LIB/features/task/screens
mkdir -p $LIB/features/task/widgets
mkdir -p $LIB/features/task/providers

touch $LIB/features/task/screens/task_create_edit_screen.dart
touch $LIB/features/task/screens/task_detail_screen.dart
touch $LIB/features/task/providers/task_provider.dart

# ── features/focus (Focus Session Screen) ─────────────────────────────────────
mkdir -p $LIB/features/focus/screens
mkdir -p $LIB/features/focus/widgets
mkdir -p $LIB/features/focus/providers

touch $LIB/features/focus/screens/focus_session_screen.dart
touch $LIB/features/focus/providers/focus_provider.dart

# ── features/session (Session End Screen) ─────────────────────────────────────
mkdir -p $LIB/features/session/screens
mkdir -p $LIB/features/session/widgets
mkdir -p $LIB/features/session/providers

touch $LIB/features/session/screens/session_end_screen.dart
touch $LIB/features/session/providers/session_provider.dart

echo "✅ UniAct folder structure created successfully."