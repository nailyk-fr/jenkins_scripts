
export USER=jenkins
MYFOLDER="$(dirname "$(realpath "$0")")"

. $MYFOLDER/colors.sh

if [ ! -d "$HOME/apps" ]; then
  mkdir ~/apps
fi

if [ ! -d "$HOME/apps/android-vts/.git" ]; then
  echo ${RED}".o0o. .o0o..o0o..o0o. $HOME/apps/android-vts/.git do not exist! .o0o. .o0o..o0o..o0o. "${NC}
  echo ${RED}".o0o. .o0o..o0o..o0o. Cloning! .o0o. .o0o..o0o..o0o. "${NC}
  cd ~/apps
  git clone https://github.com/AndroidVTS/android-vts -b master android-vts
  cd ~/apps/android-vts/
else 
  cd ~/apps/android-vts/
  echo ${GREEN}".o0o. .o0o..o0o..o0o. Patching $PWD .o0o. .o0o..o0o..o0o."${NC}
  git reset --hard
  git clean -fxd :/
  git fetch origin master
  git checkout origin/master
fi

wget "https://raw.githubusercontent.com/nailyk-fr/jenkins_scripts/nougat-mr1.1-release/patches/AndroidVTS.properties" -O local.properties
cat "/var/jenkins_home/workspace/F-Droid/.signing" >> app/gradle.properties
echo ${YELLOW}"cat returned $? "${NC}
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

if [ ! -d "$HOME/apps/mGerrit/.git" ]; then
  echo ${RED}".o0o. .o0o..o0o..o0o. $HOME/apps/mGerrit/.git do not exist! .o0o. .o0o..o0o..o0o. "${NC}
  echo ${RED}".o0o. .o0o..o0o..o0o. Cloning! .o0o. .o0o..o0o..o0o. "${NC}
  cd ~/apps
  git clone https://github.com/JBirdVegas/external_jbirdvegas_mGerrit -b master mGerrit
  cd ~/apps/mGerrit/
else 
  cd ~/apps/mGerrit/
  echo ${GREEN}".o0o. .o0o..o0o..o0o. Patching $PWD .o0o. .o0o..o0o..o0o."${NC}
  git reset --hard
  git clean -fxd :/
  git fetch origin master
  git checkout origin/master
fi

wget "https://raw.githubusercontent.com/nailyk-fr/jenkins_scripts/nougat-mr1.1-release/patches/AndroidVTS.properties" -O local.properties
cat "/var/jenkins_home/workspace/F-Droid/.signing" >> app/gradle.properties
echo ${YELLOW}"cat returned $? "${NC}
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

if [ ! -d "$HOME/apps/Tusky/.git" ]; then
  echo ${RED}".o0o. .o0o..o0o..o0o. $HOME/apps/Tusky/.git do not exist! .o0o. .o0o..o0o..o0o. "${NC}
  echo ${RED}".o0o. .o0o..o0o..o0o. Cloning! .o0o. .o0o..o0o..o0o. "${NC}
  cd ~/apps
  git clone https://github.com/tuskyapp/Tusky -b develop Tusky
  cd ~/apps/Tusky/
else 
  cd ~/apps/Tusky/
  echo ${GREEN}".o0o. .o0o..o0o..o0o. Patching $PWD .o0o. .o0o..o0o..o0o."${NC}
  git reset --hard
  git clean -fxd :/
  git fetch origin master
  git checkout origin/master
fi

wget "https://raw.githubusercontent.com/nailyk-fr/jenkins_scripts/nougat-mr1.1-release/patches/AndroidVTS.properties" -O local.properties
cat "/var/jenkins_home/workspace/F-Droid/.signing" >> app/gradle.properties
echo ${YELLOW}"cat returned $? "${NC}
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

if [ ! -d "$HOME/apps/OpenLauncher/.git" ]; then
  echo ${RED}".o0o. .o0o..o0o..o0o. $HOME/apps/OpenLauncher/.git do not exist! .o0o. .o0o..o0o..o0o. "${NC}
  echo ${RED}".o0o. .o0o..o0o..o0o. Cloning! .o0o. .o0o..o0o..o0o. "${NC}
  cd ~/apps
  git clone https://github.com/OpenLauncherTeam/openlauncher -b master OpenLauncher
  cd ~/apps/OpenLauncher/
else 
  cd ~/apps/OpenLauncher/
  echo ${GREEN}".o0o. .o0o..o0o..o0o. Patching $PWD .o0o. .o0o..o0o..o0o."${NC}
  git reset --hard
  git clean -fxd :/
  git fetch origin master
  git checkout origin/master
fi

wget "https://raw.githubusercontent.com/nailyk-fr/jenkins_scripts/nougat-mr1.1-release/patches/AndroidVTS.properties" -O local.properties
cat "/var/jenkins_home/workspace/F-Droid/.signing" >> app/gradle.properties
echo ${YELLOW}"cat returned $? "${NC}
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


if [ ! -d "$HOME/apps/Osmand/.git" ]; then
  echo ${RED}".o0o. .o0o..o0o..o0o. $HOME/apps/Osmand/.git do not exist! .o0o. .o0o..o0o..o0o. "${NC}
  echo ${RED}".o0o. .o0o..o0o..o0o. Cloning! .o0o. .o0o..o0o..o0o. "${NC}
  cd ~/apps
  git clone https://github.com/osmandapp/Osmand -b master Osmand
  cd ~/apps/Osmand/
else 
  cd ~/apps/Osmand
  echo ${GREEN}".o0o. .o0o..o0o..o0o. Patching $PWD .o0o. .o0o..o0o..o0o."${NC}
  git reset --hard
  git clean -fxd :/
  git fetch origin master
  git checkout origin/master
fi

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

if [ ! -d "$HOME/apps/vlc-android/.git" ]; then
  echo ${RED}".o0o. .o0o..o0o..o0o. $HOME/apps/vlc-android/.git do not exist! .o0o. .o0o..o0o..o0o. "${NC}
  echo ${RED}".o0o. .o0o..o0o..o0o. Cloning! .o0o. .o0o..o0o..o0o. "${NC}
  cd ~/apps
  git clone https://code.videolan.org/videolan/vlc-android -b master vlc-android --recurse-submodules
  cd ~/apps/vlc-android/
else 
  cd ~/apps/vlc-android/
  echo ${GREEN}".o0o. .o0o..o0o..o0o. Patching $PWD .o0o. .o0o..o0o..o0o."${NC}
  git reset --hard
  git clean -fxd :/
  git fetch origin master
  git checkout origin/master
fi

cp -v "/var/jenkins_home/workspace/F-Droid/.signing-vlc" gradle.properties
wget "https://raw.githubusercontent.com/nailyk-fr/jenkins_scripts/nougat-mr1.1-release/patches/AndroidVTS.properties" -O local.properties

cd ~/apps/vlc-android/vlc
git reset --hard
git clean -fxd :/
git fetch origin master
git checkout origin/master
