# Razorpay SDK keep rules
-keep class com.razorpay.** { *; }
-keep interface com.razorpay.** { *; }
-keepattributes *Annotation*
-dontwarn com.razorpay.**

# Proguard annotation compatibility
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }

# Optional: For JSON parsing, Retrofit, GSON (if used)
-keep class com.google.gson.** { *; }
-keepattributes Signature
-keepattributes *Annotation*
