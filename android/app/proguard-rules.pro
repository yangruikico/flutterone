#---------------------------------基本指令区----------------------------------
# 混淆字典
-obfuscationdictionary proguard-android.txt
-classobfuscationdictionary proguard-android.txt
-packageobfuscationdictionary proguard-android.txt



-optimizationpasses 5                   #指定代码的压缩级别
-dontusemixedcaseclassnames             #是否使用大小写混合
-dontskipnonpubliclibraryclasses        #不去忽略非公共的库类
-dontskipnonpubliclibraryclassmembers   #指定不去忽略包可见的库类的成员
-dontpreverify                          #混淆时是否做预校验
-verbose                                #混淆时是否记录日志
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*    #混淆时所采用的算法
-printmapping proguard/mapping.txt      #混淆前后的映射
-keepattributes *Annotation*            #保护注解
-keepattributes Signature               #避免混淆泛型 如果混淆报错建议关掉
-keepattributes Exceptions,InnerClasses,Deprecated,SourceFile,LineNumberTable,EnclosingMethod
-ignorewarnings                         #忽略警告
#---------------------------------默认保留区---------------------------------
#这些子类可能被外部调用
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Appliction
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class * extends android.view.View
-keep public class com.android.vending.licensing.ILicensingService
#保留support下的所有类及其内部类
-keep class android.support.** {*;}
#保留R下面的资源
-keep class *.R$ {*;}
#保留继承的
-keep public class * extends android.support.v4.**
-keep public class * extends android.support.v7.**
-keep public class * extends android.support.annotation.**
#保持 native 方法不被混淆
-keepclasseswithmembernames class * {
    native <methods>;
}
-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
}
-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet, int);
}
#保留Parcelable序列化类不被混淆
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}
#保持 Serializable 不被混淆并且enum 类也不被混淆
-keepnames class * implements java.io.Serializable
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    !private <fields>;
    !private <methods>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}
#对于带有回调函数的onXXEvent、*OnListener的，不能被混淆
-keepclassmembers class * {
    public void *ButtonClicked(android.view.View);
    void *(**On*Event);
    void *(**On*Listener);
}
#保持自定义控件类不被混淆
-keepclassmembers class * extends android.app.Activity {
   public void *(android.view.View);
}
-keep public class * extends android.view.View {
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
    public void set*(...);
    *** get*();
}
-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}
#保持枚举 enum 类不被混淆
-keepclassmembers enum * {
  public static **[] values();
  public static ** valueOf(java.lang.String);
}
 #移除Log类打印各个等级日志的代码，打正式包的时候可以做为禁log使用，这里可以作为禁止log打印的功能使用，另外的一种实现方案是通过BuildConfig.DEBUG的变量来控制
 -assumenosideeffects class android.util.Log {
     public static *** v(...);
     public static *** i(...);
     public static *** d(...);
     public static *** w(...);
     public static *** e(...);
 }
 #androidx
 -keep class com.google.android.material.** {*;}
 -keep class androidx.** {*;}
 -keep public class * extends androidx.**
 -keep interface androidx.** {*;}
 -dontwarn com.google.android.material.**
 -dontnote com.google.android.material.**
 -dontwarn androidx.**



#Flutter Wrapper
-dontwarn io.flutter.**
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }


#优化  不优化输入的类文件
-dontoptimize




















