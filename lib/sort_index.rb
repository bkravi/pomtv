module SortIndex

  SORT_KEY_ASC = 'asc'

  SORT_KEY_DESC = 'desc'

 

  SORT_DIRECTION_MAP = {

    SORT_KEY_DESC => 'DESC',

    SORT_KEY_ASC => 'ASC'

  }

 

  # The +SortIndex::Config+ class specifies all possible sort columns

  # for a given controller action including the default column and the default order

  class Config

    attr_accessor :columns

    attr_accessor :default_direction

    

    def default

      return @default

    end

    

    # The +initialize+ method;

    # both the default and columns parameters contain key value pairs

    # where the key is passed in the query string to the action and the

    # value contains the sql order by value

    # === Parameters

    # * _default_ = Hash; must contain only one pair; automatically gets added to the columns member

    # * _columns_ = Hash; one pair per sortable column

    # * _default_direction_ = String; optional, if not specified order will be DESC

    def initialize(default, columns, default_direction = nil)

      @columns = columns

      @default_direction = default_direction || SORT_KEY_DESC

      

      raise "default only supports 1 pair" if default.length != 1

      default.each_pair { |key, value|

        @default = value

        @columns[key] = value

      }

    end

  end

 

  # The +SortIndex::Sortable+ class enable sorting on index pages

  # avoids sql injection by only using values from the SortIndex::Config#columns

  # Hash and not the values passed in the query string

  class Sortable

    

    # The +initialize+ method;

    # === Parameters

    # * _params_ = the controllers params Hash

    # * _config_ = SortIndex::Config

    # * _index_url_ = String; optional, if not specified will be the name of the controller

    # ** Examples

    # *** not specified /employees (the index action)

    # *** specified /employees/special_action

    def initialize(params, config, index_url = nil)

      @config = config

      @params = params

      @index_url = index_url || params[:controller]

      

      # sets up for building the sql order by

      @sort_direction = SORT_DIRECTION_MAP[@params[:sort_direction]] || @config.default_direction

      @sort_by = @config.columns[@params[:sort_by]] || @config.default

    end

    

    # The +order+ method returns the sql order criteria

    # use with your find calls or via paginate from will_paginate plugin

    def order

      specified_sort_by || "#{@sort_by} #{@sort_direction}"

    end

    

    # The +header_link+ method returns a string of html containing the table header and a tags

    # Example: <th><a href="/employess?sort_by=first_name&amp;sort_direction=desc">First Name</a></th>

    # If the column is the currently sorted column then a css class of current-sort-asc or current-sort-describe

    # is applied; this allows you to use css to add visual indicators such as up and down arrows

    # this method is called from the view; once per column

    # === Parameters

    # * _sort_key_ = String; must be one of the key values from SortIndex::Config

    # * _display_ = The display text

    # * _sortable_ = Boolean; default is true;

    # ** passing false will not render an anchor tag; instead the display will be wrapped in a span

    def header_link(sort_key, display, sortable = true)

      if @config.columns[sort_key].nil? and sortable then

        raise "Sort key of '#{sort_key}' not found. Check your controllers SortIndex::Config variable"

      end

      

      class_attr = ""

      if @config.columns[sort_key] == @sort_by then

        class_attr = " class='current-sort-#{@sort_direction.downcase}'"

      end

      

      a_href = "<a href=\"#{@index_url}?sort_by=#{sort_key}&amp;sort_direction=#{next_direction}\" title=\"Sort by #{display}\">#{display}</a>"

      if sortable == false then

        a_href = "<span>#{display}</span>"

      end

      

      return "<th#{class_attr}>#{a_href}</th>"

    end

    

    # The +next_direction+ method is called by header_link and specifies which way the rendered

    # links should sort. Returns the opposite of the current sort

    def next_direction

      sort_direction = SORT_KEY_ASC

      if (@params[:sort_direction].nil?) then

        sort_direction = (@sort_direction == SORT_KEY_ASC) ? SORT_KEY_DESC : SORT_KEY_ASC

      elsif (@params[:sort_direction] == SORT_KEY_ASC) then

        sort_direction = SORT_KEY_DESC

      end

      return sort_direction

    end

    

    # The +specified_sort_by+ method is called by order returns the sql order by criteria

    # This can be more than one sql column; when it is multiple columns we apply the same direction to all

    # For Example if you had one header column for Employee#full_name which mapped to two

    # database columns first_name and last_name of the employees table the result would look like

    # first_name DESC, last_name DESC or last_name DESC, first_name DESC depending on your configuration

    def specified_sort_by

      sort = @config.columns[@params[:sort_by]]

      return nil if sort.nil?

      return sort.split(',').map {|order_criteria| "#{order_criteria} #{@sort_direction}"}.join(',')

    end

  end

  

end
