require "simple_method_callback/version"

module SimpleMethodCallback
  class ArgumentTypeError < StandardError; end
  def self.included(base)

    base.instance_eval do
      def around_action(around_method, only: nil)
        include ActiveSupport::Callbacks

        if only.nil?
          only = base.singleton_methods(false)
        elsif only.is_a?(Symbol) || only.is_a?(String)
          only = [only]
        end

        raise ArgumentTypeError, 'only argument type error' unless only.is_a?(Array)

        around_method_list ||= @@around_method_list ||= Set.new
        around_only_method_list ||= @@around_only_method_list ||= Set.new
        around_method_list << around_method
        around_only_method_list += only

        define_callbacks *around_only_method_list.map(&:to_sym)
        #TODO 苏铭轩 20200925 添加before 以及 after 即可实现 前置和后置回调
        # 以下这种方式比较low，需要借鉴优秀的项目是怎么去处理这种情况的
        class_variable_set('@@around_method_list', around_method_list)
        class_variable_set('@@around_only_method_list', around_only_method_list)

        extend ClassMethods
        prepend InstanceMethods
      end
    end
  end

  module ClassMethods
    def self.extended(sub)
      sub.class_variable_get('@@around_method_list').map(&:to_sym).each do |am|
        sub.class_variable_get('@@around_only_method_list').map(&:to_sym).each do |om|
          sub.set_callback om, :around, am
        end
      end
    end
  end

  module InstanceMethods
    def self.prepended(mod)
      mod.class_variable_get('@@around_only_method_list').map(&:to_sym).each do |method_name|
        define_method(method_name) do |*options|
          run_callbacks method_name do
            super(*options)
          end
        end
      end
    end
  end
end
