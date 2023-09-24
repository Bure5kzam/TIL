---
layout: post
title: ROS 서비스
date: 2023-09-12 20:01
category: ros
author: Bure5kzam
tags: []
summary: ROS 서비스 예제
---

## Concept

서비스는 `call-and-response` 모델을 따름.

토픽이 데이터를 주기적으로 계속 전송하며, 구독 요청된 노드들이 이를 수신하는 반면, 서비스는 콜백 함수만 등록해두고 클라이언트가 요청할 때만 반환한다는 점에서 다름.

[터틀봇 예제 프로그램을 통한 서비스 이해](https://docs.ros.org/en/galactic/Tutorials/Beginner-CLI-Tools/Understanding-ROS2-Services/Understanding-ROS2-Services.html)

[서비스 코드 이해](https://docs.ros.org/en/galactic/Tutorials/Beginner-Client-Libraries/Writing-A-Simple-Cpp-Service-And-Client.html)

## Service interface

서비스로 데이터를 주고받기 위해서는 통신할 데이터 인터페이스를 명시해야함.

인터페이스 파일을 빌드하면 결과 hpp 파일이 워크스페이스의 install 디렉토리에 추가됨


```srv
# tutorial_interfaces/srv/add_three_ints.hpp

int64 a
int64 b
int64 c
---
int64 sum
```

## Service server

``` c++
// add_two_ints_server.cpp

#include "rclcpp/rclcpp.hpp"

// service 정의 인터페이스
#include "tutorial_interfaces/srv/add_three_ints.hpp"

// service 콜백
void add(const std::shared_ptr<tutorial_interfaces::srv::AddThreeInts::Request> request, std::shared_ptr<tutorial_interfaces::srv::AddThreeInts::Response> response) {
  response->sum = request-> a + request->b + request->c;
  RCLCPP_INFO(rclcpp::get_logger("rclcpp"), "Incoming requeist\na: %ld" " b: %ld" " c : %ld",request->a, request->b, request->c);
  RCLCPP_INFO(rclcpp::get_logger("rclcpp"), "sending back response: [%ld]", (long int)response->sum);
}

int main(int argc, char* argv[])
{
  // rclcpp 클라이언트 라이브러리를 초기화
  rclcpp::init(argc, argv);

  // add_two_inits_server 라는 노드 생성
  std::shared_ptr<rclcpp::Node> node = rclcpp::Node::make_shared("add_two_inits_server");

  rclcpp::Service<tutorial_interfaces::srv::AddThreeInts>::SharedPtr service = node->create_service<tutorial_interfaces::srv::AddThreeInts>("add_two_ints", &add);
  // 서비스 'add_two_init'을 생성해 클라이언트에서 접속할 수 있도록 네트워크에 알림.
  // 응답할 로직을 콜백함수로 저장

  RCLCPP_INFO(rclcpp::get_logger("rclcpp"), "Ready to add two inits.");
  rclcpp::spin(node);
  rclcpp::shutdown();

}
```

서비스 생성 부분을 보면 인터페이스 정의 클래스를 템플릿으로 사용하고 있음.

코드를 정상적으로 빌드하기 위해서는 해당 자료형에 대한 의존 관계가 있다고 `CMakeList.txt`에서 명시해줘야함.

```bash
find_package(example_interfaces REQUIRED)

add_executable(server src/add_two_ints_server.cpp)
ament_target_dependencies(server
rclcpp example_interfaces)
```

ros2 run 커맨드로 찾기 위해 추가해야함.

```c
install(TARGETS
  server
  DESTINATION lib/${PROJECT_NAME})
```

## Service client

```c++
#include "rclcpp/rclcpp.hpp"
#include "tutorial_interfaces/srv/add_three_ints.hpp"

using namespace std::chrono_literals;

int main(int argc, char **argv) {
  rclcpp::init(argc, argv);

  if (argc != 4) {
    RCLCPP_INFO(rclcpp::get_logger("rclcpp"), "usage: add_two_ints_client X Y Z");
    return 1;
  }

  // 사용할 node를 생성
  std::shared_ptr<rclcpp::Node> node = rclcpp::Node::make_shared("add_three_ints_client");

  // 생성한 노드에 client를 생성. 요청할 서비스 이름은 add_two_ints.
  rclcpp::Client<tutorial_interfaces::srv::AddThreeInts>::SharedPtr client = node->create_client<tutorial_interfaces::srv::AddThreeInts>("add_two_ints");

  // srv 파일에 묘사된 대로 요청을 생성
  auto request = std::make_shared<tutorial_interfaces::srv::AddThreeInts::Request>();
  request->c = atoll(argv[3]);
  request->b = atoll(argv[2]);
  request->a = atoll(argv[1]);


  while (!client->wait_for_service(1s)) {
    if (!rclcpp::ok()) {
      RCLCPP_ERROR(rclcpp::get_logger("rclcpp"), "Interrupted while waiting for the service. Exiting.");
      return 0;
    }
    RCLCPP_INFO(rclcpp::get_logger("rclcpp"), "service not avilable, waiting again...");
  }

  auto result = client->async_send_request(request);

  if (rclcpp::spin_until_future_complete(node, result) == rclcpp::FutureReturnCode::SUCCESS) {
    RCLCPP_INFO(rclcpp::get_logger("rclcpp"), "Sum: %ld", result.get()->sum);
  } else {
    RCLCPP_ERROR(rclcpp::get_logger("rclcpp"), "Failed to call service add_two_ints");
  }
}

서버와 유사하게 클라이언트에도 의존 관계가 있다고 명시해야함.

```
