defmodule Tabby.Repo.Migrations.AddUserIdToPieces do
  use Ecto.Migration

  def change do
    alter table("pieces") do
      add :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
