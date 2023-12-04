import 'package:education_app/core/common/views/page_under_construction.dart';
import 'package:education_app/core/extensions/context_extensions.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:education_app/src/authentication/presentation/bloc/auth_bloc.dart';
import 'package:education_app/src/authentication/presentation/views/sign_in_screen.dart';
import 'package:education_app/src/authentication/presentation/views/sign_up_screen.dart';
import 'package:education_app/src/dashboard/presentation/views/dashboard.dart';
import 'package:education_app/src/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:education_app/src/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:education_app/src/onboarding/presentation/views/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'router.main.dart';
