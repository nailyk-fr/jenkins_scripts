
export USER=jenkins
MYFOLDER="$(dirname "$(realpath "$0")")"

source $MYFOLDER/colors.sh

if [ ! -d "$HOME/apps" ]; then
  mkdir ~/apps
fi
cd ~/apps/android-vts/
echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching $PWD .o0o. .o0o..o0o..o0o."${NC}
git reset --hard
git clean -fxd :/
git fetch origin master
git checkout origin/master

wget "https://raw.githubusercontent.com/nailyk-fr/jenkins_scripts/nougat-mr1.1-release/patches/AndroidVTS.properties" -O local.properties
cat "/var/jenkins_home/workspace/F-Droid/.signing" >> app/gradle.properties
echo "
android {
    signingConfigs {
       release {
           storeFile file(RELEASE_STORE_FILE)
           storePassword RELEASE_STORE_PASSWORD
           keyAlias RELEASE_KEY_ALIAS
           keyPassword RELEASE_KEY_PASSWORD
       }
    }

    buildTypes {
            release {
                signingConfig signingConfigs.release
            }
    }
}" >> app/build.gradle


cd ~/apps/mGerrit/
echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching $PWD .o0o. .o0o..o0o..o0o."${NC}
git reset --hard
git clean -fxd :/
git fetch origin master
git checkout origin/master

wget "https://raw.githubusercontent.com/nailyk-fr/jenkins_scripts/nougat-mr1.1-release/patches/AndroidVTS.properties" -O local.properties
cat "/var/jenkins_home/workspace/F-Droid/.signing" >> app/gradle.properties
echo "
android {
    signingConfigs {
       release {
           storeFile file(RELEASE_STORE_FILE)
           storePassword RELEASE_STORE_PASSWORD
           keyAlias RELEASE_KEY_ALIAS
           keyPassword RELEASE_KEY_PASSWORD
       }
    }

    buildTypes {
            release {
                signingConfig signingConfigs.release
            }
    }
}" >> app/build.gradle

echo "
diff --git a/app/build.gradle b/app/build.gradle
index 7155b2a..444c245 100644
--- a/app/build.gradle
+++ b/app/build.gradle
@@ -5,7 +5,7 @@ buildscript {
         maven { url 'https://maven.fabric.io/public' }
     }
     dependencies {
-        classpath 'com.android.tools.build:gradle:2.3.0-beta1'
+        classpath 'com.android.tools.build:gradle:2.2.3'
         classpath 'com.jakewharton.hugo:hugo-plugin:1.2.1'
         classpath 'org.apache.commons:commons-lang3:3.4'
         classpath 'org.ajoberstar:gradle-git:1.1.0'
diff --git a/build.gradle b/build.gradle
index d3a3922..c633b0c 100755
--- a/build.gradle
+++ b/build.gradle
@@ -4,7 +4,7 @@ buildscript {
         mavenCentral()
     }
     dependencies {
-        classpath 'com.android.tools.build:gradle:2.3.0-beta1'
+        classpath 'com.android.tools.build:gradle:2.2.3'
     }
 }

" | patch -p1
echo "
diff --git a/app/src/main/res/values/arrays.xml b/app/src/main/res/values/arrays.xml
index 7de304f..adcd575 100644
--- a/app/src/main/res/values/arrays.xml
+++ b/app/src/main/res/values/arrays.xml
@@ -36,6 +36,7 @@
         <item>SlimRoms</item>
         <item>Wikimedia</item>
         <item>OpenStack</item>
+        <item>Sony-Stock-Lineage</item>
     </string-array>
     <string-array name="gerrit_webaddresses" translatable="false">
         <item>http://gerrit.aicp-rom.com/</item>
@@ -56,6 +57,7 @@
         <item>https://review.slimroms.org/</item>
         <item>https://gerrit.wikimedia.org/r/</item>
         <item>https://review.openstack.org/</item>
+        <item>https://gerrit.nailyk.fr/</item>
     </string-array>
     <string-array name="status_entries" translatable="false">
         <item>@string/reviewable</item>
" | patch -p1
rm app/src/main/res/values/arrays.xml.orig || true


cd ~/apps/Tusky/
echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching $PWD .o0o. .o0o..o0o..o0o."${NC}
git reset --hard
git clean -fxd :/
git fetch origin master
git checkout origin/master

wget "https://raw.githubusercontent.com/nailyk-fr/jenkins_scripts/nougat-mr1.1-release/patches/AndroidVTS.properties" -O local.properties
cat "/var/jenkins_home/workspace/F-Droid/.signing" >> app/gradle.properties
echo "
android {
    signingConfigs {
       release {
           storeFile file(RELEASE_STORE_FILE)
           storePassword RELEASE_STORE_PASSWORD
           keyAlias RELEASE_KEY_ALIAS
           keyPassword RELEASE_KEY_PASSWORD
       }
    }

    buildTypes {
            release {
                signingConfig signingConfigs.release
            }
    }
}" >> app/build.gradle


cd ~/apps/OpenLauncher/
echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching $PWD .o0o. .o0o..o0o..o0o."${NC}
git reset --hard
git clean -fxd :/
git fetch origin master
git checkout origin/master

wget "https://raw.githubusercontent.com/nailyk-fr/jenkins_scripts/nougat-mr1.1-release/patches/AndroidVTS.properties" -O local.properties
cat "/var/jenkins_home/workspace/F-Droid/.signing" >> app/gradle.properties
echo "
android {
    signingConfigs {
       release {
           storeFile file(RELEASE_STORE_FILE)
           storePassword RELEASE_STORE_PASSWORD
           keyAlias RELEASE_KEY_ALIAS
           keyPassword RELEASE_KEY_PASSWORD
       }
    }

    buildTypes {
            release {
                signingConfig signingConfigs.release
            }
    }
}" >> app/build.gradle


cd ~/apps/Osmand
echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching $PWD .o0o. .o0o..o0o..o0o."${NC}
git reset --hard
git clean -fxd :/
git fetch origin master
git checkout origin/master
wget "https://raw.githubusercontent.com/nailyk-fr/jenkins_scripts/nougat-mr1.1-release/patches/AndroidVTS.properties" -O local.properties
cat "/var/jenkins_home/workspace/F-Droid/.signing" >> app/gradle.properties
echo "
android {
    signingConfigs {
       release {
           storeFile file(RELEASE_STORE_FILE)
           storePassword RELEASE_STORE_PASSWORD
           keyAlias RELEASE_KEY_ALIAS
           keyPassword RELEASE_KEY_PASSWORD
       }
    }

    buildTypes {
            release {
                signingConfig signingConfigs.release
            }
    }
}" >> app/build.gradle


cd ~/apps/vlc-android/
echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching $PWD .o0o. .o0o..o0o..o0o."${NC}
git reset --hard
git clean -fxd :/
git fetch origin master
git checkout origin/master
cp "/var/jenkins_home/workspace/F-Droid/.signing_vlc" gradle.properties
wget "https://raw.githubusercontent.com/nailyk-fr/jenkins_scripts/nougat-mr1.1-release/patches/AndroidVTS.properties" -O local.properties


cd ~/apps/vlc-android/vlc
git reset --hard
git clean -fxd :/
git fetch origin master
git checkout origin/master
