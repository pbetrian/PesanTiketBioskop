import 'dart:convert';

import 'package:bwa_flutix/model/models.dart';
import 'package:bwa_flutix/shared/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:bwa_flutix/extensions/extensions.dart';
import 'package:http/http.dart' as http;

part 'auth_services.dart';
part 'user_services.dart';
part 'movie_services.dart';
part 'ticket_services.dart';
part 'flutix_transaction_services.dart';