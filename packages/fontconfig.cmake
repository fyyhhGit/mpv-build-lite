ExternalProject_Add(fontconfig
    DEPENDS expat freetype2 zlib
    GIT_REPOSITORY "git://anongit.freedesktop.org/fontconfig"
    UPDATE_COMMAND ""
    PATCH_COMMAND ${EXEC} git am ${CMAKE_CURRENT_SOURCE_DIR}/fontconfig-*.patch
    CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --with-arch=${TARGET_ARCH}
        --with-expat=${MINGW_INSTALL_PREFIX}
        --disable-shared
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

ExternalProject_Add_Step(fontconfig force-update
    DEPENDEES download
    COMMAND git pull --rebase
    WORKING_DIRECTORY <SOURCE_DIR>
    ALWAYS 1
    LOG 1
)

ExternalProject_Add_Step(fontconfig autogen
    DEPENDEES download update patch
    DEPENDERS configure
    COMMAND ${EXEC} ./autogen.sh -V
    WORKING_DIRECTORY <SOURCE_DIR>
    LOG 1
)
