# CompressFactory

## CMake Paras

```shell
cmake -DCMAKE_PREFIX_PATH=C:\Qt\6.7.2\mingw_64 -DCMAKE_GENERATOR:STRING=Ninja -DCMAKE_CXX_COMPILER:FILEPATH=C:/Qt/Tools/mingw1120_64/bin/g++.exe -DCMAKE_CXX_FLAGS_INIT:STRING=-DQT_QML_DEBUG -DCMAKE_MESSAGE_LOG_LEVEL=STATUS -DCMAKE_BUILD_TYPE=Debug -S . -B build
cmake --build build
```
