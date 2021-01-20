defmodule GenSchemasEn.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias GenSchemasEn.Project
  alias GenSchemasEn.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "teams" do
    field :name, :string
    field :user_id, :binary_id

    has_many :projects, Project

    many_to_many :userteams, User, join_through: UserTeam, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name])
    |> cast_assoc(:projects, with: &Project.changeset/2)
    |> validate_required([:name])
  end
end
