alias GenSchemasEn.{Invite, Repo, User, Permission, Role, UserTeam}

create_invite =
  Permission.changeset(%Permission{}, %{
    name: "Create an Invite",
    description: "Create Invite to users join in the teams"
  })
  |> Repo.insert!()

create_project =
  Permission.changeset(%Permission{}, %{
    name: "Create a Project",
    description: "User can create projects inside the teams"
  })
  |> Repo.insert!()

moderator =
  Role.changeset(%Role{}, %{
    name: "Moderator",
    description: "Allow user only to create projects"
  })
  |> Repo.insert!()
  |> Repo.preload(:permissions)

admin =
  Role.changeset(%Role{}, %{
    name: "Admin",
    description: "Allow user todo everything"
  })
  |> Repo.insert!()
  |> Repo.preload(:permissions)

visitor =
  Role.changeset(%Role{}, %{
    name: "visitor",
    description: "User can do nothing"
  })
  |> Repo.insert!()

admin
|> Role.insert_permissions([create_invite, create_project])
|> Repo.update!()

moderator
|> Role.insert_permissions([create_project])
|> Repo.update!()

Repo.all(Role)
|> Repo.preload(:permissions)
|> IO.inspect()

user = %{
  email: "gus@gus",
  first_name: "Gustavo",
  last_name: "Oliveira",
  teams: [
    %{
      name: "Elxpro",
      projects: [
        %{title: "Ecto Class"},
        %{title: "Sass Elixir Project"}
      ]
    },
    %{
      name: "Supervisors&Childrens",
      projects: [
        %{title: "Masterclass HackerHank"}
      ]
    }
  ]
}

user =
  User.changeset(%User{}, user)
  |> Repo.insert!()
  |> Repo.preload(teams: [:projects], userteams: [])

[team | _] = user.teams

Invite.changeset(%Invite{}, %{email: "test@test", team_id: team.id, user_id: user.id})
|> Repo.insert!()
|> IO.inspect()

test =
  User.changeset(%User{}, %{
    email: "test@test",
    first_name: "Test",
    last_name: "Oliveira"
  })
  |> Repo.insert!()

user
|> User.user_belongs_teams(user.teams)
|> Repo.update!()
|> IO.inspect()

test
|> Repo.preload(:userteams)
|> User.user_belongs_teams([team])
|> Repo.update!()
|> IO.inspect()

[userteam | _] =
  Repo.all(UserTeam)
  |> Repo.preload(:roles)
  |> IO.inspect()

[role1 | _] =
  Repo.all(Role)
  |> IO.inspect()

userteam
|> UserTeam.insert_roles([role1])
|> Repo.update!()
|> IO.inspect()
