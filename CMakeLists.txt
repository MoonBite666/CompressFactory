cmake_minimum_required(VERSION 3.16)

project(CompressFactory VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(QT_VERSION VERSION_GREATER_EQUAL "6.3")
    qt_standard_project_setup()
    qt_policy(SET QTP0001 NEW)
else()
    set(CMAKE_AUTOMOC ON)
    set(CMAKE_AUTORCC ON)
    set(CMAKE_AUTOUIC ON)
endif()

set(QWINDOWKIT_BUILD_STATIC ON)
set(QWINDOWKIT_BUILD_EXAMPLES OFF)
set(QWINDOWKIT_BUILD_QUICK ON)
set(QWINDOWKIT_BUILD_WIDGETS OFF)
set(QWINDOWKIT_ENABLE_STYLE_AGENT ON)
set(QWINDOWKIT_INSTALL OFF)
add_subdirectory(3rdparty/qwindowkit)

find_package(Qt6 6.2 REQUIRED COMPONENTS Quick)


qt_add_executable(${PROJECT_NAME}
        src/main.cpp
)

qt_add_qml_module(${PROJECT_NAME}
    URI CompressFactory
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/Component/SideTabBar.qml
        qml/Component/NavButton.qml
        qml/Component/ArrowButton.qml
    RESOURCES
        res/resources.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(${PROJECT_NAME} PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.${PROJECT_NAME}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE Qt6::Quick
)

target_link_libraries(${PROJECT_NAME}
    PUBLIC QWindowKit::Quick
)
include_directories(
        3rdparty/qwindowkit/include
)


include(GNUInstallDirs)
install(TARGETS ${PROJECT_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
