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