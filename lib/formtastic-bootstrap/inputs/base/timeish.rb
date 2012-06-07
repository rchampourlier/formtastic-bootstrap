module FormtasticBootstrap
  module Inputs
    module Base
      module Timeish

        def to_html
          generic_input_wrapping do
            fragments_wrapping do
              hidden_fragments <<
              template.content_tag(:div,
                fragments.map do |fragment|
                  fragment_wrapping do
                    fragment_label_html(fragment) <<
                    fragment_input_html(fragment)
                  end
                end.join.html_safe, # TODO is this safe?
                { :class => 'fragments-group' } # TODO refactor to fragments_group_wrapping
              )
            end
          end
        end

        def fragment_wrapping(&block)
          template.content_tag(:div, template.capture(&block), fragment_wrapping_html_options)
        end

        def date_input_html
          fragment_input_html(:date, "small")
        end

        def time_input_html
          fragment_input_html(:time, "mini")
        end

        def fragment_id(fragment)
          # TODO is this right?
          # "#{input_html_options[:id]}_#{position(fragment)}i"
          "#{input_html_options[:id]}[#{fragment}]"
        end

        def fragment_label_html(fragment)
          text = fragment_label(fragment)
          text.blank? ? "".html_safe : template.content_tag(:label, text, :for => fragment_id(fragment))
        end
        
        def fragment_input_html(fragment)
          opts = input_options.merge(:prefix => fragment_prefix, :field_name => fragment_name(fragment), :default => value, :include_blank => include_blank?)
          template.send(:"select_#{fragment}", value, opts, input_html_options.merge(:id => fragment_id(fragment)))
        end

      end
    end
  end
end
