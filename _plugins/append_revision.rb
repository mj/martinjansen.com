module Jekyll
  class AppendRevisionTag < Liquid::Tag
    def initialize(tag_name, resource, tokens)
      super
      @resource = resource.strip!
    end

    def render(context)
      # I'm sure this can be done in Ruby, too. But why bother?
      rev = %x(git log -1 #{Dir.pwd}#{@resource} | awk 'NR==1 { print substr($2, 0, 8) }').strip!;

      "#{@resource}?r#{rev}"
    end
  end
end

Liquid::Template.register_tag('append_revision', Jekyll::AppendRevisionTag)
