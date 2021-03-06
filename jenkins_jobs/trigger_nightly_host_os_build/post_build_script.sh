NIGHTLY_DIR_NAME=$(cat NIGHTLY_DIR_NAME)
BUILD_TIMESTAMP=$(cat BUILD_TIMESTAMP)
BUILD_DIR_PATH="../to_build/${BUILD_TIMESTAMP}"

# update nightly build dir and latest nightly build
ln -s "$BUILD_DIR_PATH" "$NIGHTLY_DIR_NAME"
ln -s "$NIGHTLY_DIR_NAME" latest

rsync -e "ssh -i $HOME/.ssh/${UPLOAD_SERVER_USER_NAME}_id_rsa" \
      --verbose --compress --links --times --chmod=a+rwx,g+rwx,o- \
      "$NIGHTLY_DIR_NAME" \
      "${UPLOAD_SERVER_USER_NAME}@${UPLOAD_SERVER_HOST_NAME}:${UPLOAD_SERVER_NIGHTLY_DIR}/"
rsync -e "ssh -i $HOME/.ssh/${UPLOAD_SERVER_USER_NAME}_id_rsa" \
      --verbose --compress --links --times --chmod=a+rwx,g+rwx,o- \
      "latest" \
      "${UPLOAD_SERVER_USER_NAME}@${UPLOAD_SERVER_HOST_NAME}:${UPLOAD_SERVER_NIGHTLY_DIR}/"
