# SimpleMethodCallback

简单的在class添加回调，比如在service、model中

#### 使用说明
```ruby
include SimpleMethodCallback
around_action :everyday, only: %w[one two three]

def one
end

def two
end

def three
end

def everyday(&block)
  yield
end
```

作用和 `controller` 里面的 `around_action` 一样。
