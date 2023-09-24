## CMakeList.txt
```md
# 필수인 Cmake 버전
cmake_minimum_required(VERSION 3.8)
# 패키지 이름
project(action_tutorials_cpp)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# 빌드에 필요한 다른 패키지들 찾기
find_package(ament_cmake REQUIRED)
find_package(action_tutorials_interfaces REQUIRED)
find_package(rclcpp REQUIRED)
find_package(rclcpp_action REQUIRED)
find_package(rclcpp_components REQUIRED)

add_library(action_server SHARED
  src/fibonacci_action_server.cpp)

target_include_directories(action_server PRIVATE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:include>)
target_compile_definitions(action_server
  PRIVATE "ACTION_TUTORIALS_CPP_BUILDING_DLL")
ament_target_dependencies(action_server
  "action_tutorials_interfaces"
  "rclcpp"
  "rclcpp_action"
  "rclcpp_components")
rclcpp_components_register_node(action_server PLUGIN "action_tutorials_cpp::FibonacciActionServer" EXECUTABLE fibonacci_action_server)
install(TARGETS
  action_server
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  # the following line skips the linter which checks for copyrights
  # uncomment the line when a copyright and license is not present in all source files
  #set(ament_cmake_copyright_FOUND TRUE)
  # the following line skips cpplint (only works in a git repo)
  # uncomment the line when this package is not in a git repo
  #set(ament_cmake_cpplint_FOUND TRUE)
  ament_lint_auto_find_test_dependencies()
endif()

# 빌드할 대상 지정
add_library()
add_executable()

# c++에서 헤더 파일 분리와 구현할 때, 꼭 add_library와 add_executable할 필요는 없음.
# 클라이언트가 사용할 수 있어야해서 `include` 아래의 패키지 이름으로 생성될 서브 디렉토리에 설치되어야 하는 헤더들을 넣어야한다.
# 다른 폴더는 src에 넣음.
# 오직 cpp 파일들만 add_library/add_executable에서 참조될 수 있음.


# 프로젝트 셋업은 ament_package로 끝남
ament_package()
# package.xml을 설치, 패키지를 ament index에 등록, CMake 설정 파일 설치
# 다른 패키지의 CMakeLists.txt에서 find_package로 찾을 수 있도록함.
# CMakeLists.txt로부터 많은 정보를 가져오기 때문에 파일의 가장 마지막 부분에서 실행하는 것이 좋음.
# 비록 install functions

'

```

## package.xml

```xml
<?xml version="1.0"?>
<?xml-model href="http://download.ros.org/schema/package_format3.xsd" schematypens="http://www.w3.org/2001/XMLSchema"?>
<package format="3">
  <!-- https://ros.org/reps/rep-0149.html#depend-multiple -->
  <name>action_tutorials_cpp</name>
  <version>0.0.0</version>
  <description>TODO: Package description</description>
  <maintainer email="bure5kzam@gmail.com">ros</maintainer>
  <license>TODO: License declaration</license>

  <buildtool_depend>ament_cmake</buildtool_depend>
  <!-- 빌드에 필요한 rosdep 키 또는 패키지 이름을 선언 -->


  <depend>action_tutorials_interfaces</depend>
  <depend>rclcpp</depend>
  <depend>rclcpp_action</depend>
  <depend>rclcpp_components</depend>
  <!-- 패키지가 필요한 rosdep key 나 ros 패키지를 선언.
  아래를 모두 지정하는 것과 동일함.
  1. build_depend
  2. build_export_depend
  3. exec_depend을
   -->

  <test_depend>ament_lint_auto</test_depend>
  <test_depend>ament_lint_common</test_depend>

  <export>
  <!-- 패키지와 서브시스템이 임베드 되기 위해 필요한 추가적인 정보를 컨테이너 역할을 함.
  잠재적인 충돌을 피하기 위해, export 태그는 이를 처리하는 패키지와 같은 이름을 가져야함.
  -->
    <build_type>ament_cmake</build_type>
  </export>

</package>

```
