require 'csv'



## Seed roles table
Role.create! [
  { name: 'entrepreneur'  }, # user
  { name: 'freelancer'    }, # user, team-member
  { name: 'student'       }, # user
  { name: 'instructor'    }, # user
  { name: 'mentor'        }, # user, team-member
  { name: 'other'         }, # user
  
  { name: 'owner'         }, # community-member
  { name: 'administrator' }, # community-member
  { name: 'member'        }, # community-member
  
  { name: 'founder'       }, # 
  { name: 'leader'        }, # team-member
  { name: 'teammate'      }, # team-member
  { name: 'intern'        }, # team-member
  { name: 'board'         }, # 
  { name: 'investor'      }  # 
]


## Seed permissions table
Permission.create! [
  { name: 'leaders'        },
  { name: 'teammates'      },
  { name: 'interns'        },
  { name: 'freelancers'    },
  { name: 'mentors'        },
  
  { name: 'owners'         },
  { name: 'administrators' },
  { name: 'members'        }
]


## Seed privacies table
Privacy.create! [
  { name: 'public'      },
  { name: 'communities' },
  { name: 'connections' },
  { name: 'teams'       },
  { name: 'private'     }
]


## Seed degrees table
Degree.create! [
  { name: 'High School'                          },
  { name: 'Associate\'s Degree'                  },
  { name: 'Bachelor\'s Degree'                   },
  { name: 'Master\'s Degree'                     },
  { name: 'Master\'s of Business Administration' },
  { name: 'Juris Doctor'                         },
  { name: 'Doctor of Medicine'                   },
  { name: 'Doctor of Philosophy'                 },
  { name: 'Engineer\'s Degree'                   },
  { name: 'Other'                                }
]


## Seed schools table
CSV.foreach("#{Rails.root}/db/seed/schools.csv", headers: true) do |row|
  location = {
    street: row['street'],
    city:   row['city'],
    state:  row['state'],
    zip:    row['zip'].to_s.gsub(/[^\d-]/, '')
  }
  
  if School.joins(:location).where({ name: row['name'], locations: location }).count == 0
    School.create!({ name: row['name'], location: location })
  end
end


## Seed users table
CSV.foreach("#{Rails.root}/db/seed/users.csv", headers: true) do |row|
  user = User.create!({
    created_at: row['Timestamp'],
    first_name: row['First Name'],
    last_name:  row['Last Name'],
    email:      row['Email'],
    username:   row['Username'],
    skills:     row['Your Skills (separated by comma) '].to_s.strip!.split(/[\s,]*,[\s,]*/).compact!,
    interests:  row['Your Interests (seperated by comma)'].to_s.strip!.split(/[\s,]*,[\s,]*/).compact!,
    location: { description: row['Location'] },
    birthday:   row['Birthday']
  })
  
  Image.new({ payload: URI.parse(row['Photo']) })
end