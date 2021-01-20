defmodule GenSchemasEn.Invite do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:email, :team_id, :user_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "invites" do
    field :email, :string
    field :user_id, :binary_id
    field :team_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(invite, attrs) do
    invite
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
