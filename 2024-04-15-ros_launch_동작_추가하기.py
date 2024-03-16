## Launch 파일로 lifecycle 제어하기

```python

from launch_ros import event_handlers, events

...

def generate_launch_description():
  
  # launchDescription에 이벤트 
  register_event_handler_inactive_state = launch.actions.RegisterEventHandler(
    
    # 이벤트 생성 (lifecycle node 상태에 따른 전환 동작)
    event_handlers.OnStateTransition(
      target_lifecycle_node=node1    # 대상 노드
      , goal_state='inactive'        # 이벤트 동작 조건
      , entities=[                   
          # 이벤트 동작시 동작시킬 action 추가
        
          # 동작 1, 로그 출력
          launch.actions.LogInfo(msg="node 'talker' reached the 'inactive' state, 'activating'.")
        
          # 동작 2, 상태 전환 실행
          , launch.actions.EmitEvent(event=events.lifecycle.ChangeState(
              lifecycle_node_matcher=launch.events.matches_action(comm_node)
              , transition_id=lifecycle_msgs.msg.Transition.TRANSITION_ACTIVATE
              )
            )
        ,
      ],
    )
  )
```
