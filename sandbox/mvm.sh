mvn_detect() {
  maven_version=$(mvn -v > /dev/null 2>&1)
  status=$?
  echo $status
}


java_detect() {
  java_version=$(java -version > /dev/null 2>&1)
  status=$?
  echo $status
}


sudo_detect() {
  prompt=$(sudo -nv > /dev/null 2>&1)
  status=$?
  echo $status
}

echo "Hello I am the maven version manager wellknowed as mvm"

if [ "$(sudo_detect)" -eq "0" ]; then
  echo ">> sudo is allowed"

  if [ "$(java_detect)" -eq "0" ]; then
    echo ">> java is available"

    if [ "$(mvn_detect)" -eq "0" ]; then
      echo ">> mvn is already in this machine."
    else
      echo ">> mvn is not available in this machine."
    fi

  else
    echo ">> java is not installed. Java is required to maven installation"
  fi

else
  echo "sudo is not allowed. Bye!"

fi
