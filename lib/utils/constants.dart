import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const preloader =
    Center(child: CircularProgressIndicator(color: Colors.orange));

const formSpacer = SizedBox(width: 16, height: 16);
// const baseUrl = "https://uugohevjeqdxfcuyygvd.supabase.co";
// const baseKey =
//     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV1Z29oZXZqZXFkeGZjdXl5Z3ZkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDUwNjU3NzIsImV4cCI6MjAyMDY0MTc3Mn0.XvvLdN2ZnyO4IDD6meB0fM2zG1VdFmtBlgcnPYqciNc";

const formPadding = EdgeInsets.symmetric(vertical: 20, horizontal: 16);

const unexpectedErrorMessage = 'Unexpected error occurred.';
