## Seed roles table
Role.create! [
  { name: 'entrepreneur'  },
  { name: 'freelancer'    },
  { name: 'student'       },
  { name: 'instructor'    },
  { name: 'mentor'        },
  { name: 'other'         },
  { name: 'owner'         },
  { name: 'administrator' },
  { name: 'member'        },
  { name: 'founder'       },
  { name: 'leader'        },
  { name: 'teammate'      },
  { name: 'intern'        },
  { name: 'board'         },
  { name: 'investor'      }
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