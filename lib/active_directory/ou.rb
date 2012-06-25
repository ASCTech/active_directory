module ActiveDirectory
  class OU < Base

    OU_FILTER = Net::LDAP::Filter.eq(:objectClass, 'organizationalUnit')

    def self.filter
      OU_FILTER
    end

    def self.find_by_name(name)
      find(:first, Net::LDAP::Filter.eq(:ou, name))
    end

    def self.all
      find(:all, OU_FILTER)
    end

    def children
      self.class.find(:all, OU_FILTER, :in => self.dn, :scope => Net::LDAP::SearchScope_SingleLevel)
    end

    def to_s
      dn.split(/,dc=/i)[0].split(/,?ou=/i).reverse.join(' \ ').chomp(' \ ')
    end

  end
end
