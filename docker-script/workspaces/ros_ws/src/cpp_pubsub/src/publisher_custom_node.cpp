#include "rclcpp/rclcpp.hpp"
#include "std_msgs/msg/string.hpp"
using namespace std::chrono_literals;

class CustomPublisher : public rclcpp::Node {
  public:
    CustomPublisher():Node("custom_publisher"), count_(0) {
      publisher_ = this->create_publisher<std_msgs::msg::String>("topic", 10);
      timer_ = this->create_wall_timer(500ms, std::bind(&CustomPublisher::timer_callback, this));
    }

  private:
    void timer_callback() {
      //callback
      auto msg = std_msgs::msg::String();
      msg.data = "Hello, world" + std::to_string(count_++);
      RCLCPP_INFO(this->get_logger(), "Publishing : %s", msg.data.c_str());
      publisher_->publish(msg);
    }

    size_t count_;
    rclcpp::TimerBase::SharedPtr timer_;
    rclcpp::Publisher<std_msgs::msg::String>::SharedPtr publisher_;
};

int main(int argc, char* argv[])
{
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<CustomPublisher>());
  rclcpp::shutdown();
}
